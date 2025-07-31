// Copyright (c) The Thanos Authors.
// Licensed under the Apache License 2.0.

// Copyright 2016 The Prometheus Authors
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// This package is a modified copy from
// github.com/prometheus/prometheus/web/api/v1@2121b4628baa7d9d9406aa468712a6a332e77aff.

package v1

import (
	"context"
	"encoding/json"
	"math"
	"net/http"
	"sort"
	"strconv"
	"strings"
	"sync"
	"time"

	"github.com/go-kit/log"
	"github.com/opentracing/opentracing-go"
	"github.com/pkg/errors"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
	"github.com/prometheus/common/model"
	"github.com/prometheus/common/route"
	"github.com/prometheus/prometheus/model/labels"
	"github.com/prometheus/prometheus/model/timestamp"
	"github.com/prometheus/prometheus/promql"
	"github.com/prometheus/prometheus/promql/parser"
	"github.com/prometheus/prometheus/storage"
	"github.com/prometheus/prometheus/util/annotations"
	"github.com/prometheus/prometheus/util/stats"
	promqlapi "github.com/thanos-io/promql-engine/api"
	"github.com/thanos-io/promql-engine/engine"
	"github.com/thanos-io/promql-engine/logicalplan"

	"github.com/thanos-io/thanos/pkg/api"
	"github.com/thanos-io/thanos/pkg/exemplars"
	"github.com/thanos-io/thanos/pkg/exemplars/exemplarspb"
	extpromhttp "github.com/thanos-io/thanos/pkg/extprom/http"
	"github.com/thanos-io/thanos/pkg/extpromql"
	"github.com/thanos-io/thanos/pkg/gate"
	"github.com/thanos-io/thanos/pkg/logging"
	"github.com/thanos-io/thanos/pkg/metadata"
	"github.com/thanos-io/thanos/pkg/metadata/metadatapb"
	"github.com/thanos-io/thanos/pkg/query"
	"github.com/thanos-io/thanos/pkg/rules"
	"github.com/thanos-io/thanos/pkg/rules/rulespb"
	"github.com/thanos-io/thanos/pkg/runutil"
	"github.com/thanos-io/thanos/pkg/store"
	"github.com/thanos-io/thanos/pkg/store/storepb"
	"github.com/thanos-io/thanos/pkg/targets"
	"github.com/thanos-io/thanos/pkg/targets/targetspb"
	"github.com/thanos-io/thanos/pkg/tenancy"
	"github.com/thanos-io/thanos/pkg/tracing"
)

const (
	DedupParam               = "dedup"
	PartialResponseParam     = "partial_response"
	MaxSourceResolutionParam = "max_source_resolution"
	ReplicaLabelsParam       = "replicaLabels[]"
	MatcherParam             = "match[]"
	StoreMatcherParam        = "storeMatch[]"
	Step                     = "step"
	Stats                    = "stats"
	ShardInfoParam           = "shard_info"
	LookbackDeltaParam       = "lookback_delta"
	EngineParam              = "engine"
	QueryAnalyzeParam        = "analyze"
	RuleNameParam            = "rule_name[]"
	RuleGroupParam           = "rule_group[]"
	FileParam                = "file[]"
)

type PromqlEngineType string

const (
	PromqlEnginePrometheus PromqlEngineType = "prometheus"
	PromqlEngineThanos     PromqlEngineType = "thanos"
)

type ThanosEngine interface {
	promql.QueryEngine
	NewInstantQueryFromPlan(ctx context.Context, q storage.Queryable, opts promql.QueryOpts, plan logicalplan.Node, ts time.Time) (promql.Query, error)
	NewRangeQueryFromPlan(ctx context.Context, q storage.Queryable, opts promql.QueryOpts, root logicalplan.Node, start, end time.Time, step time.Duration) (promql.Query, error)
}

type QueryEngineFactory struct {
	engineOpts            promql.EngineOpts
	remoteEngineEndpoints promqlapi.RemoteEndpoints

	createPrometheusEngine sync.Once
	prometheusEngine       promql.QueryEngine

	createThanosEngine sync.Once
	thanosEngine       ThanosEngine
	enableXFunctions   bool
}

func (f *QueryEngineFactory) GetPrometheusEngine() promql.QueryEngine {
	f.createPrometheusEngine.Do(func() {
		if f.prometheusEngine != nil {
			return
		}
		f.prometheusEngine = promql.NewEngine(f.engineOpts)
	})

	return f.prometheusEngine
}

func (f *QueryEngineFactory) GetThanosEngine() ThanosEngine {
	f.createThanosEngine.Do(func() {
		opts := engine.Opts{
			EngineOpts:       f.engineOpts,
			Engine:           f.GetPrometheusEngine(),
			EnableAnalysis:   true,
			EnableXFunctions: f.enableXFunctions,
		}
		if f.thanosEngine != nil {
			return
		}
		if f.remoteEngineEndpoints == nil {
			f.thanosEngine = engine.New(opts)
		} else {
			f.thanosEngine = engine.NewDistributedEngine(opts, f.remoteEngineEndpoints)
		}
	})

	return f.thanosEngine
}

func NewQueryEngineFactory(engineOpts promql.EngineOpts, remoteEngineEndpoints promqlapi.RemoteEndpoints, enableExtendedFunctions bool) *QueryEngineFactory {
	return &QueryEngineFactory{
		engineOpts:            engineOpts,
		remoteEngineEndpoints: remoteEngineEndpoints,
		enableXFunctions:      enableExtendedFunctions,
	}
}

// QueryAPI is an API used by Thanos Querier.
type QueryAPI struct {
	baseAPI         *api.BaseAPI
	logger          log.Logger
	gate            gate.Gate
	queryableCreate query.QueryableCreator
	// queryEngine returns appropriate promql.Engine for a query with a given step.
	engineFactory       *QueryEngineFactory
	defaultEngine       PromqlEngineType
	lookbackDeltaCreate func(int64) time.Duration
	ruleGroups          rules.UnaryClient
	targets             targets.UnaryClient
	metadatas           metadata.UnaryClient
	exemplars           exemplars.UnaryClient

	enableAutodownsampling              bool
	enableQueryPartialResponse          bool
	enableRulePartialResponse           bool
	enableTargetPartialResponse         bool
	enableMetricMetadataPartialResponse bool
	enableExemplarPartialResponse       bool
	disableCORS                         bool

	replicaLabels  []string
	endpointStatus func() []query.EndpointStatus

	defaultRangeQueryStep                  time.Duration
	defaultInstantQueryMaxSourceResolution time.Duration
	defaultMetadataTimeRange               time.Duration

	queryRangeHist prometheus.Histogram

	seriesStatsAggregatorFactory store.SeriesQueryPerformanceMetricsAggregatorFactory

	tenantHeader    string
	defaultTenant   string
	tenantCertField string
	enforceTenancy  bool
	tenantLabel     string
}

// NewQueryAPI returns an initialized QueryAPI type.
func NewQueryAPI(
	logger log.Logger,
	endpointStatus func() []query.EndpointStatus,
	engineFactory *QueryEngineFactory,
	defaultEngine PromqlEngineType,
	lookbackDeltaCreate func(int64) time.Duration,
	c query.QueryableCreator,
	ruleGroups rules.UnaryClient,
	targets targets.UnaryClient,
	metadatas metadata.UnaryClient,
	exemplars exemplars.UnaryClient,
	enableAutodownsampling bool,
	enableQueryPartialResponse bool,
	enableRulePartialResponse bool,
	enableTargetPartialResponse bool,
	enableMetricMetadataPartialResponse bool,
	enableExemplarPartialResponse bool,
	replicaLabels []string,
	flagsMap map[string]string,
	defaultRangeQueryStep time.Duration,
	defaultInstantQueryMaxSourceResolution time.Duration,
	defaultMetadataTimeRange time.Duration,
	disableCORS bool,
	gate gate.Gate,
	statsAggregatorFactory store.SeriesQueryPerformanceMetricsAggregatorFactory,
	reg *prometheus.Registry,
	tenantHeader string,
	defaultTenant string,
	tenantCertField string,
	enforceTenancy bool,
	tenantLabel string,
) *QueryAPI {
	if statsAggregatorFactory == nil {
		statsAggregatorFactory = &store.NoopSeriesStatsAggregatorFactory{}
	}
	return &QueryAPI{
		baseAPI:                                api.NewBaseAPI(logger, disableCORS, flagsMap),
		logger:                                 logger,
		engineFactory:                          engineFactory,
		defaultEngine:                          defaultEngine,
		lookbackDeltaCreate:                    lookbackDeltaCreate,
		queryableCreate:                        c,
		gate:                                   gate,
		ruleGroups:                             ruleGroups,
		targets:                                targets,
		metadatas:                              metadatas,
		exemplars:                              exemplars,
		enableAutodownsampling:                 enableAutodownsampling,
		enableQueryPartialResponse:             enableQueryPartialResponse,
		enableRulePartialResponse:              enableRulePartialResponse,
		enableTargetPartialResponse:            enableTargetPartialResponse,
		enableMetricMetadataPartialResponse:    enableMetricMetadataPartialResponse,
		enableExemplarPartialResponse:          enableExemplarPartialResponse,
		replicaLabels:                          replicaLabels,
		endpointStatus:                         endpointStatus,
		defaultRangeQueryStep:                  defaultRangeQueryStep,
		defaultInstantQueryMaxSourceResolution: defaultInstantQueryMaxSourceResolution,
		defaultMetadataTimeRange:               defaultMetadataTimeRange,
		disableCORS:                            disableCORS,
		seriesStatsAggregatorFactory:           statsAggregatorFactory,
		tenantHeader:                           tenantHeader,
		defaultTenant:                          defaultTenant,
		tenantCertField:                        tenantCertField,
		enforceTenancy:                         enforceTenancy,
		tenantLabel:                            tenantLabel,

		queryRangeHist: promauto.With(reg).NewHistogram(prometheus.HistogramOpts{
			Name:    "thanos_query_range_requested_timespan_duration_seconds",
			Help:    "A histogram of the query range window in seconds",
			Buckets: prometheus.ExponentialBuckets(15*60, 2, 12),
		}),
	}
}

// Register the API's endpoints in the given router.
func (qapi *QueryAPI) Register(r *route.Router, tracer opentracing.Tracer, logger log.Logger, ins extpromhttp.InstrumentationMiddleware, logMiddleware *logging.HTTPServerMiddleware) {
	qapi.baseAPI.Register(r, tracer, logger, ins, logMiddleware)

	instr := api.GetInstr(tracer, logger, ins, logMiddleware, qapi.disableCORS)

	r.Get("/query", instr("query", qapi.query))
	r.Post("/query", instr("query", qapi.query))

	r.Get("/query_explain", instr("query", qapi.queryExplain))
	r.Post("/query_explain", instr("query", qapi.queryExplain))

	r.Get("/query_range", instr("query_range", qapi.queryRange))
	r.Post("/query_range", instr("query_range", qapi.queryRange))

	r.Get("/query_range_explain", instr("query", qapi.queryRangeExplain))
	r.Post("/query_range_explain", instr("query", qapi.queryRangeExplain))

	r.Get("/label/:name/values", instr("label_values", qapi.labelValues))

	r.Get("/series", instr("series", qapi.series))
	r.Post("/series", instr("series", qapi.series))

	r.Get("/labels", instr("label_names", qapi.labelNames))
	r.Post("/labels", instr("label_names", qapi.labelNames))

	r.Get("/stores", instr("stores", qapi.stores))

	r.Get("/alerts", instr("alerts", NewAlertsHandler(qapi.ruleGroups, qapi.enableRulePartialResponse)))
	r.Get("/rules", instr("rules", NewRulesHandler(qapi.ruleGroups, qapi.enableRulePartialResponse)))
	r.Get("/rules_debug", instr("rules_debug", NewRulesDebugHandler(qapi.ruleGroups, qapi.enableRulePartialResponse)))

	r.Get("/targets", instr("targets", NewTargetsHandler(qapi.targets, qapi.enableTargetPartialResponse)))

	r.Get("/metadata", instr("metadata", NewMetricMetadataHandler(qapi.metadatas, qapi.enableMetricMetadataPartialResponse)))

	r.Get("/query_exemplars", instr("exemplars", NewExemplarsHandler(qapi.exemplars, qapi.enableExemplarPartialResponse)))
	r.Post("/query_exemplars", instr("exemplars", NewExemplarsHandler(qapi.exemplars, qapi.enableExemplarPartialResponse)))
}

type queryData struct {
	ResultType parser.ValueType `json:"resultType"`
	Result     parser.Value     `json:"result"`
	Stats      stats.QueryStats `json:"stats,omitempty"`
	// Additional Thanos Response field.
	QueryAnalysis queryTelemetry `json:"analysis,omitempty"`
	Warnings      []error        `json:"warnings,omitempty"`
}

type queryTelemetry struct {
	// TODO(saswatamcode): Replace with engine.TrackedTelemetry once it has exported fields.
	// TODO(saswatamcode): Add aggregate fields to enrich data.
	OperatorName string           `json:"name,omitempty"`
	Execution    string           `json:"executionTime,omitempty"`
	PeakSamples  int64            `json:"peakSamples,omitempty"`
	TotalSamples int64            `json:"totalSamples,omitempty"`
	Children     []queryTelemetry `json:"children,omitempty"`
}

func (qapi *QueryAPI) parseEnableDedupParam(r *http.Request) (enableDeduplication bool, _ *api.ApiError) {
	enableDeduplication = true

	if val := r.FormValue(DedupParam); val != "" {
		var err error
		enableDeduplication, err = strconv.ParseBool(val)
		if err != nil {
			return false, &api.ApiError{Typ: api.ErrorBadData, Err: errors.Wrapf(err, "'%s' parameter", DedupParam)}
		}
	}
	return enableDeduplication, nil
}

func (qapi *QueryAPI) parseEngineParam(r *http.Request) (queryEngine promql.QueryEngine, e PromqlEngineType, _ *api.ApiError) {
	var engine promql.QueryEngine

	param := PromqlEngineType(r.FormValue("engine"))
	if param == "" {
		param = qapi.defaultEngine
	}

	switch param {
	case PromqlEnginePrometheus:
		engine = qapi.engineFactory.GetPrometheusEngine()
	case PromqlEngineThanos:
		engine = qapi.engineFactory.GetThanosEngine()
	default:
		return nil, param, &api.ApiError{Typ: api.ErrorBadData, Err: errors.Errorf("'%s' bad engine", param)}
	}

	return engine, param, nil
}

func (qapi *QueryAPI) parseReplicaLabelsParam(r *http.Request) (replicaLabels []string, _ *api.ApiError) {
	if err := r.ParseForm(); err != nil {
		return nil, &api.ApiError{Typ: api.ErrorInternal, Err: errors.Wrap(err, "parse form")}
	}

	replicaLabels = qapi.replicaLabels
	// Overwrite the cli flag when provided as a query parameter.
	if len(r.Form[ReplicaLabelsParam]) > 0 {
		replicaLabels = r.Form[ReplicaLabelsParam]
	}
	return replicaLabels, nil
}

func (qapi *QueryAPI) parseStoreDebugMatchersParam(r *http.Request) (storeMatchers [][]*labels.Matcher, _ *api.ApiError) {
	if err := r.ParseForm(); err != nil {
		return nil, &api.ApiError{Typ: api.ErrorInternal, Err: errors.Wrap(err, "parse form")}
	}

	for _, s := range r.Form[StoreMatcherParam] {
		matchers, err := extpromql.ParseMetricSelector(s)
		if err != nil {
			return nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}
		}
		storeMatchers = append(storeMatchers, matchers)
	}

	return storeMatchers, nil
}

func (qapi *QueryAPI) parseLookbackDeltaParam(r *http.Request) (time.Duration, *api.ApiError) {
	// Overwrite the cli flag when provided as a query parameter.
	if val := r.FormValue(LookbackDeltaParam); val != "" {
		var err error
		lookbackDelta, err := parseDuration(val)
		if err != nil {
			return 0, &api.ApiError{Typ: api.ErrorBadData, Err: errors.Wrapf(err, "'%s' parameter", LookbackDeltaParam)}
		}
		return lookbackDelta, nil
	}
	// If duration 0 is returned, lookback delta is taken from engine config.
	return time.Duration(0), nil
}

func (qapi *QueryAPI) parseDownsamplingParamMillis(r *http.Request, defaultVal time.Duration) (maxResolutionMillis int64, _ *api.ApiError) {
	maxSourceResolution := 0 * time.Second

	val := r.FormValue(MaxSourceResolutionParam)
	if qapi.enableAutodownsampling || (val == "auto") {
		maxSourceResolution = defaultVal
	}
	if val != "" && val != "auto" {
		var err error
		maxSourceResolution, err = parseDuration(val)
		if err != nil {
			return 0, &api.ApiError{Typ: api.ErrorBadData, Err: errors.Wrapf(err, "'%s' parameter", MaxSourceResolutionParam)}
		}
	}

	if maxSourceResolution < 0 {
		return 0, &api.ApiError{Typ: api.ErrorBadData, Err: errors.Errorf("negative '%s' is not accepted. Try a positive integer", MaxSourceResolutionParam)}
	}

	return int64(maxSourceResolution / time.Millisecond), nil
}

func (qapi *QueryAPI) parsePartialResponseParam(r *http.Request, defaultEnablePartialResponse bool) (enablePartialResponse bool, _ *api.ApiError) {
	// Overwrite the cli flag when provided as a query parameter.
	if val := r.FormValue(PartialResponseParam); val != "" {
		var err error
		defaultEnablePartialResponse, err = strconv.ParseBool(val)
		if err != nil {
			return false, &api.ApiError{Typ: api.ErrorBadData, Err: errors.Wrapf(err, "'%s' parameter", PartialResponseParam)}
		}
	}
	return defaultEnablePartialResponse, nil
}

func (qapi *QueryAPI) parseStep(r *http.Request, defaultRangeQueryStep time.Duration, rangeSeconds int64) (time.Duration, *api.ApiError) {
	// Overwrite the cli flag when provided as a query parameter.
	if val := r.FormValue(Step); val != "" {
		var err error
		defaultRangeQueryStep, err = parseDuration(val)
		if err != nil {
			return 0, &api.ApiError{Typ: api.ErrorBadData, Err: errors.Wrapf(err, "'%s' parameter", Step)}
		}
		return defaultRangeQueryStep, nil
	}
	// Default step is used this way to make it consistent with UI.
	d := time.Duration(math.Max(float64(rangeSeconds/250), float64(defaultRangeQueryStep/time.Second))) * time.Second
	return d, nil
}

func (qapi *QueryAPI) parseShardInfo(r *http.Request) (*storepb.ShardInfo, *api.ApiError) {
	data := r.FormValue(ShardInfoParam)
	if data == "" {
		return nil, nil
	}

	if len(data) == 0 {
		return nil, nil
	}

	var info storepb.ShardInfo
	if err := json.Unmarshal([]byte(data), &info); err != nil {
		return nil, &api.ApiError{Typ: api.ErrorBadData, Err: errors.Wrapf(err, "could not unmarshal parameter %s", ShardInfoParam)}
	}

	return &info, nil
}

func (qapi *QueryAPI) getQueryExplain(query promql.Query) (*engine.ExplainOutputNode, *api.ApiError) {
	if eq, ok := query.(engine.ExplainableQuery); ok {
		return eq.Explain(), nil
	}
	return nil, &api.ApiError{Typ: api.ErrorBadData, Err: errors.Errorf("Query not explainable")}

}

func (qapi *QueryAPI) parseQueryAnalyzeParam(r *http.Request, query promql.Query) (queryTelemetry, error) {
	if r.FormValue(QueryAnalyzeParam) == "true" || r.FormValue(QueryAnalyzeParam) == "1" {
		if eq, ok := query.(engine.ExplainableQuery); ok {
			return processAnalysis(eq.Analyze()), nil
		}
		return queryTelemetry{}, errors.Errorf("Query not analyzable; change engine to 'thanos'")
	}
	return queryTelemetry{}, nil
}

func processAnalysis(a *engine.AnalyzeOutputNode) queryTelemetry {
	var analysis queryTelemetry
	analysis.OperatorName = a.OperatorTelemetry.String()
	analysis.Execution = a.OperatorTelemetry.ExecutionTimeTaken().String()
	analysis.PeakSamples = a.PeakSamples()
	analysis.TotalSamples = a.TotalSamples()
	for _, c := range a.Children {
		analysis.Children = append(analysis.Children, processAnalysis(c))
	}
	return analysis
}

func (qapi *QueryAPI) queryExplain(r *http.Request) (interface{}, []error, *api.ApiError, func()) {
	engine, engineParam, apiErr := qapi.parseEngineParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	if engineParam != PromqlEngineThanos {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: errors.New("engine type must be 'thanos'")}, func() {}
	}

	ts, err := parseTimeParam(r, "time", qapi.baseAPI.Now())
	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}

	ctx := r.Context()
	if to := r.FormValue("timeout"); to != "" {
		var cancel context.CancelFunc
		timeout, err := parseDuration(to)
		if err != nil {
			return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
		}

		ctx, cancel = context.WithTimeout(ctx, timeout)
		defer cancel()
	}

	enableDedup, apiErr := qapi.parseEnableDedupParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	replicaLabels, apiErr := qapi.parseReplicaLabelsParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	storeDebugMatchers, apiErr := qapi.parseStoreDebugMatchersParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	enablePartialResponse, apiErr := qapi.parsePartialResponseParam(r, qapi.enableQueryPartialResponse)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	maxSourceResolution, apiErr := qapi.parseDownsamplingParamMillis(r, qapi.defaultInstantQueryMaxSourceResolution)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	shardInfo, apiErr := qapi.parseShardInfo(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	lookbackDelta := qapi.lookbackDeltaCreate(maxSourceResolution)
	// Get custom lookback delta from request.
	lookbackDeltaFromReq, apiErr := qapi.parseLookbackDeltaParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}
	if lookbackDeltaFromReq > 0 {
		lookbackDelta = lookbackDeltaFromReq
	}

	tenant, err := tenancy.GetTenantFromHTTP(r, qapi.tenantHeader, qapi.defaultTenant, qapi.tenantCertField)
	if err != nil {
		apiErr = &api.ApiError{Typ: api.ErrorBadData, Err: err}
		return nil, nil, apiErr, func() {}
	}
	ctx = context.WithValue(ctx, tenancy.TenantKey, tenant)

	var seriesStats []storepb.SeriesStatsCounter
	qry, err := engine.NewInstantQuery(
		ctx,
		qapi.queryableCreate(
			enableDedup,
			replicaLabels,
			storeDebugMatchers,
			maxSourceResolution,
			enablePartialResponse,
			false,
			shardInfo,
			query.NewAggregateStatsReporter(&seriesStats),
		),
		promql.NewPrometheusQueryOpts(false, lookbackDelta),
		r.FormValue("query"),
		ts,
	)

	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}

	explanation, apiErr := qapi.getQueryExplain(qry)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	return explanation, nil, nil, func() {}
}

func (qapi *QueryAPI) query(r *http.Request) (interface{}, []error, *api.ApiError, func()) {
	ts, err := parseTimeParam(r, "time", qapi.baseAPI.Now())
	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}

	ctx := r.Context()
	if to := r.FormValue("timeout"); to != "" {
		var cancel context.CancelFunc
		timeout, err := parseDuration(to)
		if err != nil {
			return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
		}

		ctx, cancel = context.WithTimeout(ctx, timeout)
		defer cancel()
	}

	enableDedup, apiErr := qapi.parseEnableDedupParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	replicaLabels, apiErr := qapi.parseReplicaLabelsParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	storeDebugMatchers, apiErr := qapi.parseStoreDebugMatchersParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	enablePartialResponse, apiErr := qapi.parsePartialResponseParam(r, qapi.enableQueryPartialResponse)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	maxSourceResolution, apiErr := qapi.parseDownsamplingParamMillis(r, qapi.defaultInstantQueryMaxSourceResolution)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	shardInfo, apiErr := qapi.parseShardInfo(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	engine, _, apiErr := qapi.parseEngineParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	lookbackDelta := qapi.lookbackDeltaCreate(maxSourceResolution)
	// Get custom lookback delta from request.
	lookbackDeltaFromReq, apiErr := qapi.parseLookbackDeltaParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}
	if lookbackDeltaFromReq > 0 {
		lookbackDelta = lookbackDeltaFromReq
	}

	queryStr, tenant, ctx, err := tenancy.RewritePromQL(ctx, r, qapi.tenantHeader, qapi.defaultTenant, qapi.tenantCertField, qapi.enforceTenancy, qapi.tenantLabel, r.FormValue("query"))
	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}

	var (
		qry         promql.Query
		seriesStats []storepb.SeriesStatsCounter
	)
	if err := tracing.DoInSpanWithErr(ctx, "instant_query_create", func(ctx context.Context) error {
		var err error
		qry, err = engine.NewInstantQuery(
			ctx,
			qapi.queryableCreate(
				enableDedup,
				replicaLabels,
				storeDebugMatchers,
				maxSourceResolution,
				enablePartialResponse,
				false,
				shardInfo,
				query.NewAggregateStatsReporter(&seriesStats),
			),
			promql.NewPrometheusQueryOpts(false, lookbackDelta),
			queryStr,
			ts,
		)
		return err
	}); err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}

	analysis, err := qapi.parseQueryAnalyzeParam(r, qry)
	if err != nil {
		return nil, nil, apiErr, func() {}
	}

	if err := tracing.DoInSpanWithErr(ctx, "query_gate_ismyturn", qapi.gate.Start); err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorExec, Err: err}, qry.Close
	}
	defer qapi.gate.Done()
	beforeRange := time.Now()

	var res *promql.Result
	tracing.DoInSpan(ctx, "instant_query_exec", func(ctx context.Context) {
		res = qry.Exec(ctx)
	})
	if res.Err != nil {
		switch res.Err.(type) {
		case promql.ErrQueryCanceled:
			return nil, nil, &api.ApiError{Typ: api.ErrorCanceled, Err: res.Err}, qry.Close
		case promql.ErrQueryTimeout:
			return nil, nil, &api.ApiError{Typ: api.ErrorTimeout, Err: res.Err}, qry.Close
		case promql.ErrStorage:
			return nil, nil, &api.ApiError{Typ: api.ErrorInternal, Err: res.Err}, qry.Close
		}
		return nil, nil, &api.ApiError{Typ: api.ErrorExec, Err: res.Err}, qry.Close
	}

	aggregator := qapi.seriesStatsAggregatorFactory.NewAggregator(tenant)
	for i := range seriesStats {
		aggregator.Aggregate(seriesStats[i])
	}
	aggregator.Observe(time.Since(beforeRange).Seconds())

	// Optional stats field in response if parameter "stats" is not empty.
	var qs stats.QueryStats
	if r.FormValue(Stats) != "" {
		qs = stats.NewQueryStats(qry.Stats())
	}
	return &queryData{
		ResultType:    res.Value.Type(),
		Result:        res.Value,
		Stats:         qs,
		QueryAnalysis: analysis,
	}, res.Warnings.AsErrors(), nil, qry.Close
}

func (qapi *QueryAPI) queryRangeExplain(r *http.Request) (interface{}, []error, *api.ApiError, func()) {
	engine, engineParam, apiErr := qapi.parseEngineParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	if engineParam != PromqlEngineThanos {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: errors.New("engine type must be 'thanos'")}, func() {}
	}

	start, err := parseTime(r.FormValue("start"))
	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}
	end, err := parseTime(r.FormValue("end"))
	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}
	if end.Before(start) {
		err := errors.New("end timestamp must not be before start time")
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}

	step, apiErr := qapi.parseStep(r, qapi.defaultRangeQueryStep, int64(end.Sub(start)/time.Second))
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	if step <= 0 {
		err := errors.New("zero or negative query resolution step widths are not accepted. Try a positive integer")
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}

	// For safety, limit the number of returned points per timeseries.
	// This is sufficient for 60s resolution for a week or 1h resolution for a year.
	if end.Sub(start)/step > 11000 {
		err := errors.New("exceeded maximum resolution of 11,000 points per timeseries. Try decreasing the query resolution (?step=XX)")
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}

	ctx := r.Context()
	if to := r.FormValue("timeout"); to != "" {
		var cancel context.CancelFunc
		timeout, err := parseDuration(to)
		if err != nil {
			return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
		}

		ctx, cancel = context.WithTimeout(ctx, timeout)
		defer cancel()
	}

	enableDedup, apiErr := qapi.parseEnableDedupParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	replicaLabels, apiErr := qapi.parseReplicaLabelsParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	storeDebugMatchers, apiErr := qapi.parseStoreDebugMatchersParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	// If no max_source_resolution is specified fit at least 5 samples between steps.
	maxSourceResolution, apiErr := qapi.parseDownsamplingParamMillis(r, step/5)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	enablePartialResponse, apiErr := qapi.parsePartialResponseParam(r, qapi.enableQueryPartialResponse)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	shardInfo, apiErr := qapi.parseShardInfo(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	lookbackDelta := qapi.lookbackDeltaCreate(maxSourceResolution)
	// Get custom lookback delta from request.
	lookbackDeltaFromReq, apiErr := qapi.parseLookbackDeltaParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}
	if lookbackDeltaFromReq > 0 {
		lookbackDelta = lookbackDeltaFromReq
	}

	tenant, err := tenancy.GetTenantFromHTTP(r, qapi.tenantHeader, qapi.defaultTenant, qapi.tenantCertField)
	if err != nil {
		apiErr = &api.ApiError{Typ: api.ErrorBadData, Err: err}
		return nil, nil, apiErr, func() {}
	}
	ctx = context.WithValue(ctx, tenancy.TenantKey, tenant)

	var seriesStats []storepb.SeriesStatsCounter
	qry, err := engine.NewRangeQuery(
		ctx,
		qapi.queryableCreate(
			enableDedup,
			replicaLabels,
			storeDebugMatchers,
			maxSourceResolution,
			enablePartialResponse,
			false,
			shardInfo,
			query.NewAggregateStatsReporter(&seriesStats),
		),
		promql.NewPrometheusQueryOpts(false, lookbackDelta),
		r.FormValue("query"),
		start,
		end,
		step,
	)
	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}

	explanation, apiErr := qapi.getQueryExplain(qry)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	return explanation, nil, nil, func() {}
}

func (qapi *QueryAPI) queryRange(r *http.Request) (interface{}, []error, *api.ApiError, func()) {
	start, err := parseTime(r.FormValue("start"))
	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}
	end, err := parseTime(r.FormValue("end"))
	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}
	if end.Before(start) {
		err := errors.New("end timestamp must not be before start time")
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}
	step, apiErr := qapi.parseStep(r, qapi.defaultRangeQueryStep, int64(end.Sub(start)/time.Second))

	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	if step <= 0 {
		err := errors.New("zero or negative query resolution step widths are not accepted. Try a positive integer")
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}

	// For safety, limit the number of returned points per timeseries.
	// This is sufficient for 60s resolution for a week or 1h resolution for a year.
	if end.Sub(start)/step > 11000 {
		err := errors.New("exceeded maximum resolution of 11,000 points per timeseries. Try decreasing the query resolution (?step=XX)")
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}

	ctx := r.Context()
	if to := r.FormValue("timeout"); to != "" {
		var cancel context.CancelFunc
		timeout, err := parseDuration(to)
		if err != nil {
			return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
		}

		ctx, cancel = context.WithTimeout(ctx, timeout)
		defer cancel()
	}

	enableDedup, apiErr := qapi.parseEnableDedupParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	replicaLabels, apiErr := qapi.parseReplicaLabelsParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	storeDebugMatchers, apiErr := qapi.parseStoreDebugMatchersParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	// If no max_source_resolution is specified fit at least 5 samples between steps.
	maxSourceResolution, apiErr := qapi.parseDownsamplingParamMillis(r, step/5)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	enablePartialResponse, apiErr := qapi.parsePartialResponseParam(r, qapi.enableQueryPartialResponse)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	shardInfo, apiErr := qapi.parseShardInfo(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	engine, _, apiErr := qapi.parseEngineParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	lookbackDelta := qapi.lookbackDeltaCreate(maxSourceResolution)
	// Get custom lookback delta from request.
	lookbackDeltaFromReq, apiErr := qapi.parseLookbackDeltaParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}
	if lookbackDeltaFromReq > 0 {
		lookbackDelta = lookbackDeltaFromReq
	}

	queryStr, tenant, ctx, err := tenancy.RewritePromQL(ctx, r, qapi.tenantHeader, qapi.defaultTenant, qapi.tenantCertField, qapi.enforceTenancy, qapi.tenantLabel, r.FormValue("query"))
	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}

	// Record the query range requested.
	qapi.queryRangeHist.Observe(end.Sub(start).Seconds())

	var (
		qry         promql.Query
		seriesStats []storepb.SeriesStatsCounter
	)
	if err := tracing.DoInSpanWithErr(ctx, "range_query_create", func(ctx context.Context) error {
		var err error
		qry, err = engine.NewRangeQuery(
			ctx,
			qapi.queryableCreate(
				enableDedup,
				replicaLabels,
				storeDebugMatchers,
				maxSourceResolution,
				enablePartialResponse,
				false,
				shardInfo,
				query.NewAggregateStatsReporter(&seriesStats),
			),
			promql.NewPrometheusQueryOpts(false, lookbackDelta),
			queryStr,
			start,
			end,
			step,
		)
		return err
	}); err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}
	analysis, err := qapi.parseQueryAnalyzeParam(r, qry)
	if err != nil {
		return nil, nil, apiErr, func() {}
	}

	if err := tracing.DoInSpanWithErr(ctx, "query_gate_ismyturn", qapi.gate.Start); err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorExec, Err: err}, qry.Close
	}
	defer qapi.gate.Done()

	var res *promql.Result
	tracing.DoInSpan(ctx, "range_query_exec", func(ctx context.Context) {
		res = qry.Exec(ctx)

	})
	beforeRange := time.Now()
	if res.Err != nil {
		switch res.Err.(type) {
		case promql.ErrQueryCanceled:
			return nil, nil, &api.ApiError{Typ: api.ErrorCanceled, Err: res.Err}, qry.Close
		case promql.ErrQueryTimeout:
			return nil, nil, &api.ApiError{Typ: api.ErrorTimeout, Err: res.Err}, qry.Close
		}
		return nil, nil, &api.ApiError{Typ: api.ErrorExec, Err: res.Err}, qry.Close
	}
	aggregator := qapi.seriesStatsAggregatorFactory.NewAggregator(tenant)
	for i := range seriesStats {
		aggregator.Aggregate(seriesStats[i])
	}
	aggregator.Observe(time.Since(beforeRange).Seconds())

	// Optional stats field in response if parameter "stats" is not empty.
	var qs stats.QueryStats
	if r.FormValue(Stats) != "" {
		qs = stats.NewQueryStats(qry.Stats())
	}
	return &queryData{
		ResultType:    res.Value.Type(),
		Result:        res.Value,
		Stats:         qs,
		QueryAnalysis: analysis,
	}, res.Warnings.AsErrors(), nil, qry.Close
}

func (qapi *QueryAPI) labelValues(r *http.Request) (interface{}, []error, *api.ApiError, func()) {
	ctx := r.Context()
	name := route.Param(ctx, "name")

	if !model.LabelNameRE.MatchString(name) {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: errors.Errorf("invalid label name: %q", name)}, func() {}
	}

	start, end, err := parseMetadataTimeRange(r, qapi.defaultMetadataTimeRange)
	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}

	enablePartialResponse, apiErr := qapi.parsePartialResponseParam(r, qapi.enableQueryPartialResponse)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	storeDebugMatchers, apiErr := qapi.parseStoreDebugMatchersParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	limit, err := parseLimitParam(r.FormValue("limit"))
	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}

	matcherSets, ctx, err := tenancy.RewriteLabelMatchers(ctx, r, qapi.tenantHeader, qapi.defaultTenant, qapi.tenantCertField, qapi.enforceTenancy, qapi.tenantLabel, r.Form[MatcherParam])
	if err != nil {
		apiErr = &api.ApiError{Typ: api.ErrorBadData, Err: err}
		return nil, nil, apiErr, func() {}
	}

	q, err := qapi.queryableCreate(
		true,
		nil,
		storeDebugMatchers,
		0,
		enablePartialResponse,
		true,
		nil,
		query.NoopSeriesStatsReporter,
	).Querier(timestamp.FromTime(start), timestamp.FromTime(end))
	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorExec, Err: err}, func() {}
	}
	defer runutil.CloseWithLogOnErr(qapi.logger, q, "queryable labelValues")

	hints := &storage.LabelHints{
		Limit: toHintLimit(limit),
	}

	var (
		vals     []string
		warnings annotations.Annotations
	)
	if len(matcherSets) > 0 {
		var callWarnings annotations.Annotations
		labelValuesSet := make(map[string]struct{})
		for _, matchers := range matcherSets {
			vals, callWarnings, err = q.LabelValues(ctx, name, hints, matchers...)
			if err != nil {
				return nil, nil, &api.ApiError{Typ: api.ErrorExec, Err: err}, func() {}
			}
			warnings.Merge(callWarnings)
			for _, val := range vals {
				labelValuesSet[val] = struct{}{}
			}
		}

		vals = make([]string, 0, len(labelValuesSet))
		for val := range labelValuesSet {
			vals = append(vals, val)
		}
		sort.Strings(vals)
	} else {
		vals, warnings, err = q.LabelValues(ctx, name, hints)
		if err != nil {
			return nil, nil, &api.ApiError{Typ: api.ErrorExec, Err: err}, func() {}
		}
	}

	if vals == nil {
		vals = make([]string, 0)
	}

	if limit > 0 && len(vals) > limit {
		vals = vals[:limit]
		warnings = warnings.Add(errors.New("results truncated due to limit"))
	}

	return vals, warnings.AsErrors(), nil, func() {}
}

func (qapi *QueryAPI) series(r *http.Request) (interface{}, []error, *api.ApiError, func()) {
	if err := r.ParseForm(); err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorInternal, Err: errors.Wrap(err, "parse form")}, func() {}
	}

	if len(r.Form[MatcherParam]) == 0 {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: errors.New("no match[] parameter provided")}, func() {}
	}

	start, end, err := parseMetadataTimeRange(r, qapi.defaultMetadataTimeRange)
	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}

	matcherSets, ctx, err := tenancy.RewriteLabelMatchers(r.Context(), r, qapi.tenantHeader, qapi.defaultTenant, qapi.tenantCertField, qapi.enforceTenancy, qapi.tenantLabel, r.Form[MatcherParam])
	if err != nil {
		apiErr := &api.ApiError{Typ: api.ErrorBadData, Err: err}
		return nil, nil, apiErr, func() {}
	}

	enableDedup, apiErr := qapi.parseEnableDedupParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	replicaLabels, apiErr := qapi.parseReplicaLabelsParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	storeDebugMatchers, apiErr := qapi.parseStoreDebugMatchersParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	limit, err := parseLimitParam(r.FormValue("limit"))
	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}

	enablePartialResponse, apiErr := qapi.parsePartialResponseParam(r, qapi.enableQueryPartialResponse)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	q, err := qapi.queryableCreate(
		enableDedup,
		replicaLabels,
		storeDebugMatchers,
		math.MaxInt64,
		enablePartialResponse,
		true,
		nil,
		query.NoopSeriesStatsReporter,
	).Querier(timestamp.FromTime(start), timestamp.FromTime(end))

	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorExec, Err: err}, func() {}
	}
	defer runutil.CloseWithLogOnErr(qapi.logger, q, "queryable series")

	var (
		metrics = []labels.Labels{}
		sets    []storage.SeriesSet
	)

	hints := &storage.SelectHints{
		Limit: toHintLimit(limit),
		Start: start.UnixMilli(),
		End:   end.UnixMilli(),
	}

	for _, mset := range matcherSets {
		sets = append(sets, q.Select(ctx, false, hints, mset...))
	}

	set := storage.NewMergeSeriesSet(sets, storage.ChainedSeriesMerge)
	warnings := set.Warnings()
	for set.Next() {
		metrics = append(metrics, set.At().Labels())
		if limit > 0 && len(metrics) > limit {
			metrics = metrics[:limit]
			warnings.Add(errors.New("results truncated due to limit"))
			return metrics, warnings.AsErrors(), nil, func() {}
		}
	}
	if set.Err() != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorExec, Err: set.Err()}, func() {}
	}
	return metrics, warnings.AsErrors(), nil, func() {}
}

func (qapi *QueryAPI) labelNames(r *http.Request) (interface{}, []error, *api.ApiError, func()) {
	start, end, err := parseMetadataTimeRange(r, qapi.defaultMetadataTimeRange)
	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}

	enablePartialResponse, apiErr := qapi.parsePartialResponseParam(r, qapi.enableQueryPartialResponse)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	storeDebugMatchers, apiErr := qapi.parseStoreDebugMatchersParam(r)
	if apiErr != nil {
		return nil, nil, apiErr, func() {}
	}

	limit, err := parseLimitParam(r.FormValue("limit"))
	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
	}

	matcherSets, ctx, err := tenancy.RewriteLabelMatchers(r.Context(), r, qapi.tenantHeader, qapi.defaultTenant, qapi.tenantCertField, qapi.enforceTenancy, qapi.tenantLabel, r.Form[MatcherParam])
	if err != nil {
		apiErr := &api.ApiError{Typ: api.ErrorBadData, Err: err}
		return nil, nil, apiErr, func() {}
	}

	q, err := qapi.queryableCreate(
		true,
		nil,
		storeDebugMatchers,
		0,
		enablePartialResponse,
		true,
		nil,
		query.NoopSeriesStatsReporter,
	).Querier(timestamp.FromTime(start), timestamp.FromTime(end))
	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorExec, Err: err}, func() {}
	}
	defer runutil.CloseWithLogOnErr(qapi.logger, q, "queryable labelNames")

	var (
		names    []string
		warnings annotations.Annotations
	)

	hints := &storage.LabelHints{
		Limit: toHintLimit(limit),
	}

	if len(matcherSets) > 0 {
		var callWarnings annotations.Annotations
		labelNamesSet := make(map[string]struct{})
		for _, matchers := range matcherSets {
			names, callWarnings, err = q.LabelNames(ctx, hints, matchers...)
			if err != nil {
				return nil, nil, &api.ApiError{Typ: api.ErrorExec, Err: err}, func() {}
			}
			warnings.Merge(callWarnings)
			for _, val := range names {
				labelNamesSet[val] = struct{}{}
			}
		}

		names = make([]string, 0, len(labelNamesSet))
		for name := range labelNamesSet {
			names = append(names, name)
		}
		sort.Strings(names)
	} else {
		names, warnings, err = q.LabelNames(ctx, hints)
	}

	if err != nil {
		return nil, nil, &api.ApiError{Typ: api.ErrorExec, Err: err}, func() {}
	}
	if names == nil {
		names = make([]string, 0)
	}

	if limit > 0 && len(names) > limit {
		names = names[:limit]
		warnings = warnings.Add(errors.New("results truncated due to limit"))
	}

	return names, warnings.AsErrors(), nil, func() {}
}

func (qapi *QueryAPI) stores(_ *http.Request) (interface{}, []error, *api.ApiError, func()) {
	statuses := make(map[string][]query.EndpointStatus)
	for _, status := range qapi.endpointStatus() {
		// Don't consider an endpoint if we cannot retrieve component type.
		if status.ComponentType == nil {
			continue
		}
		statuses[status.ComponentType.String()] = append(statuses[status.ComponentType.String()], status)
	}
	return statuses, nil, nil, func() {}
}

// NewTargetsHandler created handler compatible with HTTP /api/v1/targets https://prometheus.io/docs/prometheus/latest/querying/api/#targets
// which uses gRPC Unary Targets API.
func NewTargetsHandler(client targets.UnaryClient, enablePartialResponse bool) func(*http.Request) (interface{}, []error, *api.ApiError, func()) {
	ps := storepb.PartialResponseStrategy_ABORT
	if enablePartialResponse {
		ps = storepb.PartialResponseStrategy_WARN
	}

	return func(r *http.Request) (interface{}, []error, *api.ApiError, func()) {
		stateParam := r.URL.Query().Get("state")
		state, ok := targetspb.TargetsRequest_State_value[strings.ToUpper(stateParam)]
		if !ok {
			if stateParam != "" {
				return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: errors.Errorf("invalid targets parameter state='%v'", stateParam)}, func() {}
			}
			state = int32(targetspb.TargetsRequest_ANY)
		}

		req := &targetspb.TargetsRequest{
			State:                   targetspb.TargetsRequest_State(state),
			PartialResponseStrategy: ps,
		}

		t, warnings, err := client.Targets(r.Context(), req)
		if err != nil {
			return nil, nil, &api.ApiError{Typ: api.ErrorInternal, Err: errors.Wrap(err, "retrieving targets")}, func() {}
		}

		return t, warnings.AsErrors(), nil, func() {}
	}
}

// NewAlertsHandler created handler compatible with HTTP /api/v1/alerts https://prometheus.io/docs/prometheus/latest/querying/api/#alerts
// which uses gRPC Unary Rules API (Rules API works for both /alerts and /rules).
func NewAlertsHandler(client rules.UnaryClient, enablePartialResponse bool) func(*http.Request) (interface{}, []error, *api.ApiError, func()) {
	ps := storepb.PartialResponseStrategy_ABORT
	if enablePartialResponse {
		ps = storepb.PartialResponseStrategy_WARN
	}

	return func(r *http.Request) (interface{}, []error, *api.ApiError, func()) {
		span, ctx := tracing.StartSpan(r.Context(), "receive_http_request")
		defer span.Finish()

		var (
			groups   *rulespb.RuleGroups
			warnings annotations.Annotations
			err      error
		)

		// TODO(bwplotka): Allow exactly the same functionality as query API: passing replica, dedup and partial response as HTTP params as well.
		req := &rulespb.RulesRequest{
			Type:                    rulespb.RulesRequest_ALERT,
			PartialResponseStrategy: ps,
		}
		tracing.DoInSpan(ctx, "retrieve_rules", func(ctx context.Context) {
			groups, warnings, err = client.Rules(ctx, req)
		})
		if err != nil {
			return nil, nil, &api.ApiError{Typ: api.ErrorInternal, Err: errors.Errorf("error retrieving rules: %v", err)}, func() {}
		}

		var resp struct {
			Alerts []*rulespb.AlertInstance `json:"alerts"`
		}
		for _, g := range groups.Groups {
			for _, r := range g.Rules {
				a := r.GetAlert()
				if a == nil {
					continue
				}
				resp.Alerts = append(resp.Alerts, a.Alerts...)
			}
		}
		return resp, warnings.AsErrors(), nil, func() {}
	}
}

// NewRulesHandler created handler compatible with HTTP /api/v1/rules https://prometheus.io/docs/prometheus/latest/querying/api/#rules
// which uses gRPC Unary Rules API.
func NewRulesHandler(client rules.UnaryClient, enablePartialResponse bool) func(*http.Request) (interface{}, []error, *api.ApiError, func()) {
	ps := storepb.PartialResponseStrategy_ABORT
	if enablePartialResponse {
		ps = storepb.PartialResponseStrategy_WARN
	}

	return func(r *http.Request) (interface{}, []error, *api.ApiError, func()) {
		span, ctx := tracing.StartSpan(r.Context(), "receive_http_request")
		defer span.Finish()

		var (
			groups   *rulespb.RuleGroups
			warnings annotations.Annotations
			err      error
		)

		typeParam := r.URL.Query().Get("type")
		typ, ok := rulespb.RulesRequest_Type_value[strings.ToUpper(typeParam)]
		if !ok {
			typ = int32(rulespb.RulesRequest_ALL)
		}

		// TODO(bwplotka): Allow exactly the same functionality as query API: passing replica, dedup and partial response as HTTP params as well.
		req := &rulespb.RulesRequest{
			Type:                    rulespb.RulesRequest_Type(typ),
			PartialResponseStrategy: ps,
			MatcherString:           r.Form[MatcherParam],
			RuleName:                r.Form[RuleNameParam],
			RuleGroup:               r.Form[RuleGroupParam],
			File:                    r.Form[FileParam],
		}
		tracing.DoInSpan(ctx, "retrieve_rules", func(ctx context.Context) {
			groups, warnings, err = client.Rules(ctx, req)
		})
		if err != nil {
			return nil, nil, &api.ApiError{Typ: api.ErrorExec, Err: err}, func() {}
		}

		// Debug rules in query API handler before response
		rules.DebugRuleGroups(log.NewNopLogger(), groups.Groups, "query_api_response", "query_api", nil)

		return groups, warnings.AsErrors(), nil, func() {}
	}
}

// NewRulesDebugHandler creates a debug handler that shows rule information with SHA256 hashes from different components
func NewRulesDebugHandler(client rules.UnaryClient, enablePartialResponse bool) func(*http.Request) (interface{}, []error, *api.ApiError, func()) {
	ps := storepb.PartialResponseStrategy_ABORT
	if enablePartialResponse {
		ps = storepb.PartialResponseStrategy_WARN
	}

	return func(r *http.Request) (interface{}, []error, *api.ApiError, func()) {
		span, ctx := tracing.StartSpan(r.Context(), "receive_http_request")
		defer span.Finish()

		var (
			groups   *rulespb.RuleGroups
			warnings annotations.Annotations
			err      error
		)

		typeParam := r.URL.Query().Get("type")
		typ, ok := rulespb.RulesRequest_Type_value[strings.ToUpper(typeParam)]
		if !ok {
			typ = int32(rulespb.RulesRequest_ALL)
		}

		req := &rulespb.RulesRequest{
			Type:                    rulespb.RulesRequest_Type(typ),
			PartialResponseStrategy: ps,
			MatcherString:           r.Form[MatcherParam],
			RuleName:                r.Form[RuleNameParam],
			RuleGroup:               r.Form[RuleGroupParam],
			File:                    r.Form[FileParam],
		}

		tracing.DoInSpan(ctx, "retrieve_rules", func(ctx context.Context) {
			groups, warnings, err = client.Rules(ctx, req)
		})
		if err != nil {
			return nil, nil, &api.ApiError{Typ: api.ErrorExec, Err: err}, func() {}
		}

		// Collect debug information from actual pipeline components stored in global cache
		allDebugInfo := rules.GetAllDebugInfo()

		// If no cached debug info available, fallback to current collection
		if len(allDebugInfo) == 0 {
			allDebugInfo = rules.CollectMultiComponentDebugInfo(groups.Groups, nil)
		}

		// Merge debug info from multiple components into a single response
		mergedDebugInfo := mergeComponentDebugInfo(allDebugInfo)

		// Add field differences to each rule debug info
		for _, ruleInfo := range mergedDebugInfo {
			ruleInfo.FieldDifferences = rules.GetFieldDifferences(ruleInfo)
		}

		response := &rulespb.RulesDebugResponse{
			Rules: mergedDebugInfo,
		}

		return response, warnings.AsErrors(), nil, func() {}
	}
}

// mergeComponentDebugInfo merges debug information from different components
// for the same rule, combining SHA256 hashes from all processing stages
func mergeComponentDebugInfo(debugInfoList []*rulespb.RuleDebugInfo) []*rulespb.RuleDebugInfo {
	// Group debug info by rule identity (group_name + rule_name + rule_type)
	ruleMap := make(map[string]*rulespb.RuleDebugInfo)

	for _, info := range debugInfoList {
		// Create a unique key for each rule
		ruleKey := info.GroupName + "|" + info.RuleName + "|" + info.RuleType

		existing, exists := ruleMap[ruleKey]
		if !exists {
			// First time seeing this rule, create new entry
			ruleMap[ruleKey] = &rulespb.RuleDebugInfo{
				GroupName:        info.GroupName,
				RuleName:         info.RuleName,
				RuleType:         info.RuleType,
				Query:            info.Query,
				Labels:           info.Labels,
				Annotations:      info.Annotations,
				ComponentSha256S: append([]*rulespb.ComponentSha256{}, info.ComponentSha256S...),
			}
		} else {
			// Rule already exists, merge SHA256 information from different components
			for _, newSha := range info.ComponentSha256S {
				// Check if we already have SHA256 for this component
				found := false
				for i, existingSha := range existing.ComponentSha256S {
					if existingSha.Component == newSha.Component {
						// Update existing component SHA256
						existing.ComponentSha256S[i] = newSha
						found = true
						break
					}
				}
				if !found {
					// Add new component SHA256
					existing.ComponentSha256S = append(existing.ComponentSha256S, newSha)
				}
			}
		}
	}

	// Convert map back to slice
	result := make([]*rulespb.RuleDebugInfo, 0, len(ruleMap))
	for _, info := range ruleMap {
		result = append(result, info)
	}

	return result
}

// NewExemplarsHandler creates handler compatible with HTTP /api/v1/query_exemplars https://prometheus.io/docs/prometheus/latest/querying/api/#querying-exemplars
// which uses gRPC Unary Exemplars API.
func NewExemplarsHandler(client exemplars.UnaryClient, enablePartialResponse bool) func(*http.Request) (interface{}, []error, *api.ApiError, func()) {
	ps := storepb.PartialResponseStrategy_ABORT
	if enablePartialResponse {
		ps = storepb.PartialResponseStrategy_WARN
	}

	return func(r *http.Request) (interface{}, []error, *api.ApiError, func()) {
		span, ctx := tracing.StartSpan(r.Context(), "exemplar_query_request")
		defer span.Finish()

		var (
			data     []*exemplarspb.ExemplarData
			warnings annotations.Annotations
			err      error
		)

		start, err := parseTimeParam(r, "start", infMinTime)
		if err != nil {
			return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
		}
		end, err := parseTimeParam(r, "end", infMaxTime)
		if err != nil {
			return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: err}, func() {}
		}

		req := &exemplarspb.ExemplarsRequest{
			Start:                   timestamp.FromTime(start),
			End:                     timestamp.FromTime(end),
			Query:                   r.FormValue("query"),
			PartialResponseStrategy: ps,
		}

		tracing.DoInSpan(ctx, "retrieve_exemplars", func(ctx context.Context) {
			data, warnings, err = client.Exemplars(ctx, req)
		})

		if err != nil {
			return nil, nil, &api.ApiError{Typ: api.ErrorInternal, Err: errors.Wrap(err, "retrieving exemplars")}, func() {}
		}
		return data, warnings.AsErrors(), nil, func() {}
	}
}

var (
	infMinTime = time.Unix(math.MinInt64/1000+62135596801, 0)
	infMaxTime = time.Unix(math.MaxInt64/1000-62135596801, 999999999)
)

func parseMetadataTimeRange(r *http.Request, defaultMetadataTimeRange time.Duration) (time.Time, time.Time, error) {
	// If start and end time not specified as query parameter, we get the range from the beginning of time by default.
	var defaultStartTime, defaultEndTime time.Time
	if defaultMetadataTimeRange == 0 {
		defaultStartTime = infMinTime
		defaultEndTime = infMaxTime
	} else {
		now := time.Now()
		defaultStartTime = now.Add(-defaultMetadataTimeRange)
		defaultEndTime = now
	}

	start, err := parseTimeParam(r, "start", defaultStartTime)
	if err != nil {
		return time.Time{}, time.Time{}, &api.ApiError{Typ: api.ErrorBadData, Err: err}
	}
	end, err := parseTimeParam(r, "end", defaultEndTime)
	if err != nil {
		return time.Time{}, time.Time{}, &api.ApiError{Typ: api.ErrorBadData, Err: err}
	}
	if end.Before(start) {
		return time.Time{}, time.Time{}, &api.ApiError{
			Typ: api.ErrorBadData,
			Err: errors.New("end timestamp must not be before start time"),
		}
	}

	return start, end, nil
}

func parseTimeParam(r *http.Request, paramName string, defaultValue time.Time) (time.Time, error) {
	val := r.FormValue(paramName)
	if val == "" {
		return defaultValue, nil
	}
	result, err := parseTime(val)
	if err != nil {
		return time.Time{}, errors.Wrapf(err, "Invalid time value for '%s'", paramName)
	}
	return result, nil
}

func parseTime(s string) (time.Time, error) {
	if t, err := strconv.ParseFloat(s, 64); err == nil {
		s, ns := math.Modf(t)
		ns = math.Round(ns*1000) / 1000
		return time.Unix(int64(s), int64(ns*float64(time.Second))), nil
	}
	if t, err := time.Parse(time.RFC3339Nano, s); err == nil {
		return t, nil
	}
	return time.Time{}, errors.Errorf("cannot parse %q to a valid timestamp", s)
}

func parseDuration(s string) (time.Duration, error) {
	if d, err := strconv.ParseFloat(s, 64); err == nil {
		ts := d * float64(time.Second)
		if ts > float64(math.MaxInt64) || ts < float64(math.MinInt64) {
			return 0, errors.Errorf("cannot parse %q to a valid duration. It overflows int64", s)
		}
		return time.Duration(ts), nil
	}
	if d, err := model.ParseDuration(s); err == nil {
		return time.Duration(d), nil
	}
	return 0, errors.Errorf("cannot parse %q to a valid duration", s)
}

// parseLimitParam returning 0 means no limit is to be applied.
func parseLimitParam(s string) (int, error) {
	if s == "" {
		return 0, nil
	}

	limit, err := strconv.Atoi(s)
	if err != nil {
		return 0, errors.Errorf("cannot parse %q to a valid limit", s)
	}
	if limit < 0 {
		return 0, errors.New("limit must be non-negative")
	}

	return limit, nil
}

// toHintLimit increases the API limit, as returned by parseLimitParam, by 1.
// This allows for emitting warnings when the results are truncated.
func toHintLimit(limit int) int {
	// 0 means no limit and avoid int overflow
	if limit > 0 && limit < math.MaxInt {
		return limit + 1
	}
	return limit
}

// NewMetricMetadataHandler creates handler compatible with HTTP /api/v1/metadata https://prometheus.io/docs/prometheus/latest/querying/api/#querying-metric-metadata
// which uses gRPC Unary Metadata API.
func NewMetricMetadataHandler(client metadata.UnaryClient, enablePartialResponse bool) func(*http.Request) (interface{}, []error, *api.ApiError, func()) {
	ps := storepb.PartialResponseStrategy_ABORT
	if enablePartialResponse {
		ps = storepb.PartialResponseStrategy_WARN
	}

	return func(r *http.Request) (interface{}, []error, *api.ApiError, func()) {
		span, ctx := tracing.StartSpan(r.Context(), "metadata_http_request")
		defer span.Finish()

		var (
			t        map[string][]metadatapb.Meta
			warnings annotations.Annotations
			err      error
		)

		req := &metadatapb.MetricMetadataRequest{
			// By default we use -1, which means no limit.
			Limit:                   -1,
			Metric:                  r.URL.Query().Get("metric"),
			PartialResponseStrategy: ps,
		}

		limitStr := r.URL.Query().Get("limit")
		if limitStr != "" {
			limit, err := strconv.ParseInt(limitStr, 10, 32)
			if err != nil {
				return nil, nil, &api.ApiError{Typ: api.ErrorBadData, Err: errors.Errorf("invalid metric metadata limit='%v'", limit)}, func() {}
			}
			req.Limit = int32(limit)
		}

		tracing.DoInSpan(ctx, "retrieve_metadata", func(ctx context.Context) {
			t, warnings, err = client.MetricMetadata(ctx, req)
		})
		if err != nil {
			return nil, nil, &api.ApiError{Typ: api.ErrorInternal, Err: errors.Wrap(err, "retrieving metadata")}, func() {}
		}

		return t, warnings.AsErrors(), nil, func() {}
	}
}

// RulesDebugUI serves the HTML page for rules debug visualization
func (qapi *QueryAPI) RulesDebugUI(w http.ResponseWriter, r *http.Request) {
	htmlTemplate := `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rules Debug - Thanos</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .header { background: #007bff; color: white; padding: 20px; border-radius: 8px; margin-bottom: 20px; }
        .container { max-width: 1200px; margin: 0 auto; }
        .filters { background: white; padding: 20px; border-radius: 8px; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .filter-group { display: flex; gap: 15px; align-items: center; flex-wrap: wrap; }
        .rule-card { background: white; border-radius: 8px; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .rule-header { background: #f8f9fa; padding: 15px; border-bottom: 1px solid #dee2e6; }
        .rule-title { font-size: 1.2em; font-weight: bold; color: #212529; }
        .rule-meta { font-size: 0.9em; color: #6c757d; margin-top: 8px; }
        .components-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(400px, 1fr)); gap: 15px; padding: 20px; }
        .component-box { border: 2px solid #e9ecef; border-radius: 6px; padding: 15px; }
        .component-box.corrupted { border-color: #dc3545; background: #f8d7da; }
        .component-box.clean { border-color: #28a745; background: #d4edda; }
        .component-name { font-weight: bold; margin-bottom: 10px; font-size: 0.9em; word-break: break-word; line-height: 1.3; }
        .sha256-hash { font-family: monospace; font-size: 0.8em; word-break: break-all; background: #f1f3f4; padding: 8px; border-radius: 4px; }
        .status-indicator { display: inline-block; width: 12px; height: 12px; border-radius: 50%; margin-right: 8px; }
        .status-indicator.clean { background: #28a745; }
        .status-indicator.corrupted { background: #dc3545; }
        .loading { text-align: center; padding: 40px; color: #6c757d; }
        .error { background: #f8d7da; color: #721c24; padding: 15px; border-radius: 4px; margin: 20px 0; }
        button { background: #007bff; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; }
        button:hover { background: #0056b3; }
        input, select { padding: 6px; border: 1px solid #ced4da; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🔍 Rules Debug - Component Integrity Analysis</h1>
            <p>Identify which components are corrupting rule data by comparing SHA256 hashes</p>
        </div>

        <div class="filters">
            <div class="filter-group">
                <label>Type:</label>
                <select id="type-filter">
                    <option value="">All</option>
                    <option value="alert">Alert</option>
                    <option value="recording">Recording</option>
                </select>
                <label>Group:</label>
                <input type="text" id="group-filter" placeholder="Filter by group name">
                <label>Rule:</label>
                <input type="text" id="rule-filter" placeholder="Filter by rule name">
                <label>Status:</label>
                <select id="status-filter">
                    <option value="">All</option>
                    <option value="corrupted">Corrupted Only</option>
                    <option value="clean">Clean Only</option>
                </select>
                <button onclick="loadRulesDebug()">🔄 Refresh</button>
            </div>
        </div>

        <div id="loading" class="loading">Loading rules debug information...</div>
        <div id="error" class="error" style="display: none;"></div>
        <div id="rules-container"></div>
    </div>

    <script>
        let allRules = [];

        async function loadRulesDebug() {
            const loading = document.getElementById('loading');
            const error = document.getElementById('error');
            const container = document.getElementById('rules-container');

            loading.style.display = 'block';
            error.style.display = 'none';
            container.innerHTML = '';

            try {
                const params = new URLSearchParams();
                const typeFilter = document.getElementById('type-filter').value;
                if (typeFilter) params.append('type', typeFilter);

                const response = await fetch('/api/v1/rules_debug?' + params.toString());
                if (!response.ok) throw new Error('HTTP ' + response.status + ': ' + response.statusText);

                const data = await response.json();
                allRules = data.data?.rules || [];

                loading.style.display = 'none';
                renderRules();
            } catch (err) {
                loading.style.display = 'none';
                error.style.display = 'block';
                error.textContent = 'Failed to load rules debug data: ' + err.message;
            }
        }

        function renderRules() {
            const container = document.getElementById('rules-container');
            const groupFilter = document.getElementById('group-filter').value.toLowerCase();
            const ruleFilter = document.getElementById('rule-filter').value.toLowerCase();
            const statusFilter = document.getElementById('status-filter').value;

            container.innerHTML = '';

            allRules.forEach(rule => {
                if (groupFilter && !rule.group_name.toLowerCase().includes(groupFilter)) return;
                if (ruleFilter && !rule.rule_name.toLowerCase().includes(ruleFilter)) return;

                const isCorrupted = rule.component_sha256s && rule.component_sha256s.length > 1 &&
                    rule.component_sha256s.some(comp => comp.sha256 !== rule.component_sha256s[0].sha256);

                if (statusFilter === 'corrupted' && !isCorrupted) return;
                if (statusFilter === 'clean' && isCorrupted) return;

                const ruleElement = createRuleElement(rule, isCorrupted);
                container.appendChild(ruleElement);
            });
        }

        function createRuleElement(rule, isCorrupted) {
            const ruleDiv = document.createElement('div');
            ruleDiv.className = 'rule-card';

            const statusIndicator = '<span class="status-indicator ' + (isCorrupted ? 'corrupted' : 'clean') + '"></span>';
            const statusText = isCorrupted ? 'CORRUPTED' : 'CLEAN';

            ruleDiv.innerHTML =
                '<div class="rule-header">' +
                    '<div class="rule-title">' + escapeHtml(rule.rule_name) + '</div>' +
                    '<div class="rule-meta">' +
                        '<span>Type: ' + rule.rule_type + '</span> | ' +
                        '<span>Group: ' + escapeHtml(rule.group_name) + '</span> | ' +
                        statusIndicator + statusText +
                    '</div>' +
                '</div>' +
                (isCorrupted ? createCorruptionDetails(rule) : '') +
                '<div class="components-grid">' +
                    (rule.component_sha256s && rule.component_sha256s.length > 0 ?
                        rule.component_sha256s.map(comp => createComponentBox(comp, rule)).join('') :
                        '<div style="padding: 20px; text-align: center; color: #6c757d;">No component data available</div>'
                    ) +
                '</div>' +
                (rule.component_sha256s && rule.component_sha256s.length === 1 ?
                    '<div style="margin: 15px; padding: 10px; background: #fff3cd; border-radius: 4px; color: #856404;">' +
                        '<strong>Note:</strong> Only one component found. Corruption detection requires multiple components for comparison.' +
                    '</div>' : '') +
                '<div style="margin: 15px; padding: 15px; background: #f8f9fa; border-radius: 4px;">' +
                    '<div style="margin-bottom: 10px;"><strong>Query:</strong><br><code style="background: white; padding: 5px; display: block; border-radius: 3px;">' + escapeHtml(rule.query || 'N/A') + '</code></div>' +
                    '<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">' +
                        '<div><strong>Labels:</strong><br>' + formatLabels(rule.labels) + '</div>' +
                        '<div><strong>Annotations:</strong><br>' + formatLabels(rule.annotations) + '</div>' +
                    '</div>' +
                '</div>';

            return ruleDiv;
        }

        function createCorruptionDetails(rule) {
            if (!rule.component_sha256s || rule.component_sha256s.length < 2) {
                return '';
            }

            const referenceHash = rule.component_sha256s[0].sha256;
            const referenceComponent = rule.component_sha256s[0].component;
            const corruptedComponents = [];

            for (let i = 1; i < rule.component_sha256s.length; i++) {
                const comp = rule.component_sha256s[i];
                if (comp.sha256 !== referenceHash) {
                    corruptedComponents.push(comp);
                }
            }

            if (corruptedComponents.length === 0) {
                return '';
            }

            // Log corruption details to console for debugging
            console.warn('Rule corruption detected:', {
                rule: rule.rule_name,
                group: rule.group_name,
                referenceComponent: referenceComponent,
                referenceHash: referenceHash,
                corruptedComponents: corruptedComponents,
                query: rule.query,
                labels: rule.labels,
                annotations: rule.annotations
            });

            let details = '<div style="margin: 15px; padding: 15px; background: #f8d7da; border: 1px solid #f5c6cb; border-radius: 4px; color: #721c24;">' +
                '<h4 style="margin: 0 0 10px 0; color: #721c24;"><i class="fas fa-exclamation-triangle"></i> CORRUPTION DETECTED</h4>' +
                '<div style="margin-bottom: 10px;"><strong>Reference component:</strong> ' + escapeHtml(referenceComponent) + '</div>' +
                '<div style="margin-bottom: 10px;"><strong>Reference hash:</strong> <code style="background: rgba(255,255,255,0.7); padding: 2px 4px; border-radius: 3px;">' + referenceHash + '</code></div>' +
                '<div style="margin-bottom: 10px;"><strong>Corrupted components:</strong></div>' +
                '<ul style="margin: 5px 0 10px 20px;">';

            corruptedComponents.forEach(comp => {
                details += '<li><strong>' + escapeHtml(comp.component) + ':</strong> <code style="background: rgba(255,255,255,0.7); padding: 2px 4px; border-radius: 3px;">' + comp.sha256 + '</code></li>';
            });

            details += '</ul>' +
                createDetailedCorruptionAnalysis(rule, referenceComponent, corruptedComponents) +
                '</div>';

            return details;
        }

        function createDetailedCorruptionAnalysis(rule, referenceComponent, corruptedComponents) {
            let analysis = '<div style="margin-top: 15px; padding: 10px; background: #fff3cd; border: 1px solid #ffeaa7; border-radius: 4px;">' +
                '<h5 style="margin: 0 0 10px 0; color: #856404;"><i class="fas fa-search"></i> Detailed Corruption Analysis</h5>' +
                '<div style="margin-bottom: 8px;"><strong>Rule:</strong> ' + escapeHtml(rule.rule_name) + ' in group ' + escapeHtml(rule.group_name) + '</div>';

            // Show pipeline corruption trail
            const components = rule.component_sha256s;
            const referenceHash = components[0].sha256;

            analysis += '<div style="margin-bottom: 10px;"><strong>Pipeline Analysis:</strong></div>' +
                '<div style="font-family: monospace; font-size: 0.9em; margin-left: 10px;">';

            components.forEach((comp, index) => {
                const isCorrupted = comp.sha256 !== referenceHash;
                const icon = isCorrupted ? '✗' : '✓';
                const status = isCorrupted ? 'CORRUPTED' : (index === 0 ? 'Reference' : 'Unchanged');
                const color = isCorrupted ? '#dc3545' : '#28a745';
                const compName = parseComponentName(comp.component);

                analysis += '<div style="margin: 5px 0; color: ' + color + ';">' +
                    icon + ' Component ' + (index + 1) + ': <strong>' + escapeHtml(compName) + '</strong> (' + status + ': ' + comp.sha256.substring(0, 16) + '...)</div>';

                if (isCorrupted && index > 0) {
                    const prevComp = components[index - 1];
                    const prevName = parseComponentName(prevComp.component);
                    analysis += '<div style="margin-left: 20px; color: #856404; font-size: 0.85em;">' +
                        '└─ Corruption occurred between "' + escapeHtml(prevName) + '" and "' + escapeHtml(compName) + '"</div>' +
                        '<div style="margin-left: 20px; color: #856404; font-size: 0.85em;">' +
                        '└─ Previous hash: ' + prevComp.sha256.substring(0, 16) + '... → Current hash: ' + comp.sha256.substring(0, 16) + '...</div>';

                    // Add troubleshooting guidance
                    const guidance = getCorruptionGuidance(prevComp.component, comp.component);
                    guidance.forEach(guide => {
                        analysis += '<div style="margin-left: 20px; color: #856404; font-size: 0.85em;">💡 ' + escapeHtml(guide) + '</div>';
                    });
                }
            });

            analysis += '</div>';

            // Show exact field differences if available
            if (rule.field_differences && rule.field_differences.length > 0) {
                analysis += '<div style="margin-top: 15px; padding: 10px; background: #fff8e1; border: 2px solid #ffc107; border-radius: 4px;">' +
                    '<h5 style="margin: 0 0 10px 0; color: #e65100;"><i class="fas fa-microscope"></i> Exact Field Differences</h5>' +
                    '<div style="font-family: monospace; font-size: 0.9em; background: #fffbf0; padding: 8px; border-radius: 3px;">';

                rule.field_differences.forEach(diff => {
                    analysis += '<div style="margin: 3px 0; color: #d84315; font-weight: bold;">🔍 ' + escapeHtml(diff) + '</div>';
                });

                analysis += '</div></div>';
            }

            // Show current rule content for inspection
            analysis += '<div style="margin-top: 15px;"><strong>Current Rule Content (for manual inspection):</strong></div>' +
                '<div style="font-family: monospace; font-size: 0.9em; background: #f8f9fa; padding: 8px; border-radius: 3px; margin-top: 5px;">' +
                '<div><strong>Query:</strong> ' + escapeHtml(rule.query) + '</div>';

            if (rule.labels && rule.labels.labels && rule.labels.labels.length > 0) {
                analysis += '<div style="margin-top: 5px;"><strong>Labels:</strong></div>';
                rule.labels.labels.forEach(label => {
                    analysis += '<div style="margin-left: 10px;">• ' + escapeHtml(label.name) + ': ' + escapeHtml(label.value) + '</div>';
                });
            }

            if (rule.annotations && rule.annotations.labels && rule.annotations.labels.length > 0) {
                analysis += '<div style="margin-top: 5px;"><strong>Annotations:</strong></div>';
                rule.annotations.labels.forEach(annotation => {
                    analysis += '<div style="margin-left: 10px;">• ' + escapeHtml(annotation.name) + ': ' + escapeHtml(annotation.value) + '</div>';
                });
            }

            analysis += '</div></div>';
            return analysis;
        }

        function parseComponentName(fullComponent) {
            // Format: hostname_file_function_line_stage_url
            const parts = fullComponent.split('_');
            if (parts.length < 5) {
                return fullComponent;
            }

            let file = parts[1];
            const func = parts[2];
            const stage = parts.slice(4).join('_');

            // Remove .go extension for cleaner display
            if (file.endsWith('.go')) {
                file = file.slice(0, -3);
            }

            return file + ':' + func + ' [' + stage + ']';
        }

        function getCorruptionGuidance(fromComponent, toComponent) {
            const fromStage = extractStage(fromComponent);
            const toStage = extractStage(toComponent);

            const guidance = [];

            // Provide specific guidance based on pipeline transition
            if (fromStage.includes('proxy') && toStage.includes('grpc')) {
                guidance.push('Check query proxy filtering/transformation logic');
                guidance.push('Verify gRPC client deduplication is not modifying rule content');
                guidance.push('Check if matchers or filters are altering rules unexpectedly');
            } else if (fromStage.includes('prometheus') && toStage.includes('manager')) {
                guidance.push('Check Prometheus API response parsing');
                guidance.push('Verify rules manager proto conversion logic');
                guidance.push('Look for encoding/UTF-8 issues in rule content');
            } else if (fromStage.includes('manager') && toStage.includes('proxy')) {
                guidance.push('Check rules manager serialization');
                guidance.push('Verify proxy rule forwarding logic');
                guidance.push('Look for gRPC streaming issues');
            } else {
                guidance.push('Check for data transformation between these components');
                guidance.push('Verify serialization/deserialization logic');
                guidance.push('Look for encoding or character set issues');
            }

            guidance.push('Enable debug logging in both components for detailed analysis');
            return guidance;
        }

        function extractStage(component) {
            const parts = component.split('_');
            if (parts.length >= 5) {
                return parts.slice(4).join('_');
            }
            return component;
        }

        function createComponentBox(component, rule) {
            const referenceHash = rule.component_sha256s[0]?.sha256;
            const isCorrupted = component.sha256 !== referenceHash;

            // Parse meaningful component identifier: hostname_filename_function_line_stage_url
            const componentParts = component.component.split('_');
            let displayInfo = {
                hostname: 'unknown',
                file: 'unknown',
                function: 'unknown',
                line: 'unknown',
                stage: 'unknown',
                url: ''
            };

            if (componentParts.length >= 5) {
                displayInfo.hostname = componentParts[0];
                displayInfo.file = componentParts[1];
                displayInfo.function = componentParts[2];
                displayInfo.line = componentParts[3];
                displayInfo.stage = componentParts[4];
                if (componentParts.length > 5) {
                    displayInfo.url = componentParts.slice(5).join('_');
                }
            }

            return '<div class="component-box ' + (isCorrupted ? 'corrupted' : 'clean') + '">' +
                '<div class="component-name">' +
                    '<span class="status-indicator ' + (isCorrupted ? 'corrupted' : 'clean') + '"></span>' +
                    '<div style="font-weight: bold; margin-bottom: 5px;">' + escapeHtml(displayInfo.hostname + ' / ' + displayInfo.stage) + '</div>' +
                    '<div style="font-size: 0.8em; color: #6c757d; margin-bottom: 3px;">File: ' + escapeHtml(displayInfo.file) + ':' + escapeHtml(displayInfo.line) + '</div>' +
                    '<div style="font-size: 0.8em; color: #6c757d; margin-bottom: 3px;">Function: ' + escapeHtml(displayInfo.function) + '</div>' +
                    (displayInfo.url ? '<div style="font-size: 0.8em; color: #6c757d;">URL: ' + escapeHtml(displayInfo.url.replace(/_/g, ':')) + '</div>' : '') +
                '</div>' +
                '<div class="sha256-hash">' + component.sha256 + '</div>' +
                '<div style="margin-top: 8px; font-size: 0.75em; color: #6c757d; font-family: monospace;">Full ID: ' + escapeHtml(component.component) + '</div>' +
            '</div>';
        }

        function formatLabels(labelsObj) {
            if (!labelsObj || typeof labelsObj !== 'object') {
                return '<em>None</em>';
            }

            const entries = Object.entries(labelsObj);
            if (entries.length === 0) {
                return '<em>None</em>';
            }

            return entries.map(([key, value]) =>
                '<div style="background: white; padding: 3px 6px; margin: 2px 0; border-radius: 3px; font-family: monospace; font-size: 0.9em;">' +
                '<strong>' + escapeHtml(key) + ':</strong> ' + escapeHtml(value) +
                '</div>'
            ).join('');
        }

        function escapeHtml(text) {
            if (text === null || text === undefined) return '';
            const div = document.createElement('div');
            div.textContent = String(text);
            return div.innerHTML;
        }

        // Event listeners
        document.getElementById('group-filter').addEventListener('input', renderRules);
        document.getElementById('rule-filter').addEventListener('input', renderRules);
        document.getElementById('status-filter').addEventListener('change', renderRules);

        // Load initial data
        loadRulesDebug();
    </script>
</body>
</html>`

	w.Header().Set("Content-Type", "text/html; charset=utf-8")
	w.WriteHeader(http.StatusOK)
	w.Write([]byte(htmlTemplate))
}
