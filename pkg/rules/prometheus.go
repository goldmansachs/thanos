// Copyright (c) The Thanos Authors.
// Licensed under the Apache License 2.0.

package rules

import (
	"net/url"
	"strings"
	"unicode/utf8"

	"github.com/go-kit/log"
	"github.com/go-kit/log/level"
	"github.com/prometheus/prometheus/model/labels"

	"github.com/thanos-io/thanos/pkg/promclient"
	"github.com/thanos-io/thanos/pkg/rules/rulespb"
	"github.com/thanos-io/thanos/pkg/store/labelpb"
)

// Prometheus implements rulespb.Rules gRPC that allows to fetch rules from Prometheus HTTP api/v1/rules endpoint.
type Prometheus struct {
	base   *url.URL
	client *promclient.Client
	logger log.Logger

	extLabels func() labels.Labels
}

// NewPrometheus creates new rules.Prometheus.
func NewPrometheus(base *url.URL, client *promclient.Client, extLabels func() labels.Labels, logger log.Logger) *Prometheus {
	return &Prometheus{
		base:      base,
		client:    client,
		extLabels: extLabels,
		logger:    logger,
	}
}

// Rules returns all specified rules from Prometheus.
func (p *Prometheus) Rules(r *rulespb.RulesRequest, s rulespb.Rules_RulesServer) error {
	var typeRules string
	if r.Type != rulespb.RulesRequest_ALL {
		typeRules = strings.ToLower(r.Type.String())
	}
	groups, err := p.client.RulesInGRPC(s.Context(), p.base, typeRules)
	if err != nil {
		return err
	}

	// Debug UTF-8 validation before enrichment
	debugRuleGroupsUTF8(p.logger, groups, "before_enrichment", p.base.String())

	// Prometheus does not add external labels, so we need to add on our own.
	enrichRulesWithExtLabels(groups, p.extLabels())

	// Debug UTF-8 validation after enrichment
	debugRuleGroupsUTF8(p.logger, groups, "after_enrichment", p.base.String())

	for _, g := range groups {
		if err := s.Send(&rulespb.RulesResponse{Result: &rulespb.RulesResponse_Group{Group: g}}); err != nil {
			return err
		}
	}
	return nil
}

// extLset has to be sorted.
func enrichRulesWithExtLabels(groups []*rulespb.RuleGroup, extLset labels.Labels) {
	for _, g := range groups {
		for _, r := range g.Rules {
			r.SetLabels(labelpb.ExtendSortedLabels(r.GetLabels(), extLset))
		}
	}
}

// debugRuleGroupsUTF8 validates UTF-8 encoding in rule groups and logs issues
func debugRuleGroupsUTF8(logger log.Logger, groups []*rulespb.RuleGroup, stage, source string) {
	for _, g := range groups {
		for _, r := range g.Rules {
			// Get rule identifier
			var ruleID string
			if recording := r.GetRecording(); recording != nil {
				ruleID = recording.Name
			} else if alert := r.GetAlert(); alert != nil {
				ruleID = alert.Name
			}

			// Check rule labels
			for _, lbl := range r.GetLabels() {
				if !utf8.ValidString(lbl.Name) {
					level.Debug(logger).Log(
						"msg", "invalid UTF-8 in rule label name",
						"stage", stage,
						"source", source,
						"group", g.Name,
						"rule", ruleID,
						"label_name", lbl.Name,
						"label_name_hex", []byte(lbl.Name),
					)
				}
				if !utf8.ValidString(lbl.Value) {
					level.Debug(logger).Log(
						"msg", "invalid UTF-8 in rule label value",
						"stage", stage,
						"source", source,
						"group", g.Name,
						"rule", ruleID,
						"label_name", lbl.Name,
						"label_value", lbl.Value,
						"label_value_hex", []byte(lbl.Value),
					)
				}
			}

			// Check rule annotations (only for alerting rules)
			if alertRule := r.GetAlert(); alertRule != nil {
				if len(alertRule.Annotations.Labels) > 0 {
					for _, annotation := range alertRule.Annotations.Labels {
						if !utf8.ValidString(annotation.Name) {
							level.Debug(logger).Log(
								"msg", "invalid UTF-8 in rule annotation key",
								"stage", stage,
								"source", source,
								"group", g.Name,
								"alert", alertRule.Name,
								"annotation_key", annotation.Name,
								"annotation_key_hex", []byte(annotation.Name),
							)
						}
						if !utf8.ValidString(annotation.Value) {
							level.Debug(logger).Log(
								"msg", "invalid UTF-8 in rule annotation value",
								"stage", stage,
								"source", source,
								"group", g.Name,
								"alert", alertRule.Name,
								"annotation_key", annotation.Name,
								"annotation_value", annotation.Value,
								"annotation_value_hex", []byte(annotation.Value),
							)
						}
					}
				}
			}
		}
	}
}
