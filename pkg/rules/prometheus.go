// Copyright (c) The Thanos Authors.
// Licensed under the Apache License 2.0.

package rules

import (
	"crypto/sha256"
	"fmt"
	"net/url"
	"os"
	"runtime"
	"strings"
	"sync"

	"github.com/go-kit/log"
	"github.com/go-kit/log/level"
	"github.com/prometheus/prometheus/model/labels"

	"github.com/thanos-io/thanos/pkg/promclient"
	"github.com/thanos-io/thanos/pkg/rules/rulespb"
	"github.com/thanos-io/thanos/pkg/store/labelpb"
)

// getComponentIdentifier generates a component identifier including host, file, function, and line
func getComponentIdentifier(stage string, baseURL *url.URL) string {
	// Get hostname
	hostname, err := os.Hostname()
	if err != nil {
		hostname = "unknown-host"
	}

	// Get caller information - we need to skip frames to get to the real calling location
	// Call stack: getComponentIdentifier -> CollectRuleDebugInfoWithID -> DebugRuleGroups -> [Real Caller]
	// So we skip 3 frames to get to the real caller
	pc, file, line, ok := runtime.Caller(3)
	var functionName string
	var fileName string

	if ok {
		// Get function name
		fn := runtime.FuncForPC(pc)
		if fn != nil {
			functionName = fn.Name()
			// Extract just the function name without package path
			if lastSlash := strings.LastIndex(functionName, "/"); lastSlash >= 0 {
				functionName = functionName[lastSlash+1:]
			}
			if lastDot := strings.LastIndex(functionName, "."); lastDot >= 0 {
				functionName = functionName[lastDot+1:]
			}
		} else {
			functionName = "unknown-func"
		}

		// Extract just the filename without full path
		if lastSlash := strings.LastIndex(file, "/"); lastSlash >= 0 {
			fileName = file[lastSlash+1:]
		} else {
			fileName = file
		}
	} else {
		functionName = "unknown-func"
		fileName = "unknown-file"
		line = 0
	}

	// Include base URL info for for multiple endpoints
	var urlInfo string
	if baseURL != nil {
		urlInfo = fmt.Sprintf("_%s", baseURL.Host)
		// Clean up URL to make it filesystem-safe
		urlInfo = strings.ReplaceAll(urlInfo, ":", "_")
		urlInfo = strings.ReplaceAll(urlInfo, "/", "_")
	}

	return fmt.Sprintf("%s_%s_%s_%d_%s%s", hostname, fileName, functionName, line, stage, urlInfo)
}

// Simple LRU cache implementation
type LRUCache struct {
	capacity int
	cache    map[string]*Node
	head     *Node
	tail     *Node
	mutex    sync.RWMutex
}

type Node struct {
	key  string
	prev *Node
	next *Node
}

func NewLRUCache(capacity int) *LRUCache {
	head := &Node{}
	tail := &Node{}
	head.next = tail
	tail.prev = head

	return &LRUCache{
		capacity: capacity,
		cache:    make(map[string]*Node),
		head:     head,
		tail:     tail,
	}
}

func (c *LRUCache) Get(key string) bool {
	c.mutex.Lock()
	defer c.mutex.Unlock()

	if node, exists := c.cache[key]; exists {
		c.moveToHead(node)
		return true
	}
	return false
}

func (c *LRUCache) Put(key string) {
	c.mutex.Lock()
	defer c.mutex.Unlock()

	if node, exists := c.cache[key]; exists {
		c.moveToHead(node)
		return
	}

	newNode := &Node{key: key}
	c.cache[key] = newNode
	c.addToHead(newNode)

	if len(c.cache) > c.capacity {
		tail := c.removeTail()
		delete(c.cache, tail.key)
	}
}

func (c *LRUCache) addToHead(node *Node) {
	node.prev = c.head
	node.next = c.head.next
	c.head.next.prev = node
	c.head.next = node
}

func (c *LRUCache) removeNode(node *Node) {
	node.prev.next = node.next
	node.next.prev = node.prev
}

func (c *LRUCache) moveToHead(node *Node) {
	c.removeNode(node)
	c.addToHead(node)
}

func (c *LRUCache) removeTail() *Node {
	lastNode := c.tail.prev
	c.removeNode(lastNode)
	return lastNode
}

// Global LRU cache for annotation debugging
var annotationCache = NewLRUCache(10000)

// Global debug info cache for rules processing pipeline
var globalDebugCache = struct {
	sync.RWMutex
	debugInfo map[string][]*rulespb.RuleDebugInfo
}{
	debugInfo: make(map[string][]*rulespb.RuleDebugInfo),
}

// StoreDebugInfo stores debug information from a pipeline stage in the global cache
func StoreDebugInfo(stage string, debugInfo []*rulespb.RuleDebugInfo) {
	globalDebugCache.Lock()
	defer globalDebugCache.Unlock()

	globalDebugCache.debugInfo[stage] = debugInfo
}

// GetAllDebugInfo retrieves all debug information from different pipeline stages
func GetAllDebugInfo() []*rulespb.RuleDebugInfo {
	globalDebugCache.RLock()
	defer globalDebugCache.RUnlock()

	var allDebugInfo []*rulespb.RuleDebugInfo
	for _, debugInfo := range globalDebugCache.debugInfo {
		allDebugInfo = append(allDebugInfo, debugInfo...)
	}

	return allDebugInfo
}

// ClearDebugCache clears the global debug cache (useful for testing or periodic cleanup)
func ClearDebugCache() {
	globalDebugCache.Lock()
	defer globalDebugCache.Unlock()

	globalDebugCache.debugInfo = make(map[string][]*rulespb.RuleDebugInfo)
}

// generateAnnotationSHA256 creates a SHA256 hash for the annotation debug entry
func generateAnnotationSHA256(stage, source, baseURL, group, alert, annotationKey, annotationValue string) string {
	data := fmt.Sprintf("%s|%s|%s|%s|%s|%s|%s", stage, source, baseURL, group, alert, annotationKey, annotationValue)
	hash := sha256.Sum256([]byte(data))
	return fmt.Sprintf("%x", hash)
}

// generateRuleSHA256 creates a SHA256 hash for rule content (query, label keys/values, annotation values)
// Excludes replica labels from calculation as they can be removed during deduplication
func generateRuleSHA256(component, groupName, ruleName, ruleType, query string, labels, annotations []labelpb.ZLabel) string {
	var data strings.Builder

	// Only include query value
	data.WriteString(query)

	// Add labels (keys and values) - exclude replica labels
	for _, label := range labels {
		if label.Name != "replica" {
			data.WriteString(fmt.Sprintf("|L:%s=%s", label.Name, label.Value))
		}
	}

	// Add annotation values only
	for _, annotation := range annotations {
		data.WriteString(fmt.Sprintf("|A:%s", annotation.Value))
	}

	hash := sha256.Sum256([]byte(data.String()))
	return fmt.Sprintf("%x", hash)
}

// CollectRuleDebugInfo collects debug information for rules from multiple components
func CollectRuleDebugInfo(groups []*rulespb.RuleGroup, componentName string) []*rulespb.RuleDebugInfo {
	var debugInfo []*rulespb.RuleDebugInfo

	for _, group := range groups {
		for _, rule := range group.Rules {
			var ruleType, ruleName, query string
			var labels, annotations []labelpb.ZLabel

			if alertRule := rule.GetAlert(); alertRule != nil {
				ruleType = "alert"
				ruleName = alertRule.Name
				query = alertRule.Query
				labels = alertRule.Labels.Labels
				annotations = alertRule.Annotations.Labels
			} else if recordingRule := rule.GetRecording(); recordingRule != nil {
				ruleType = "recording"
				ruleName = recordingRule.Name
				query = recordingRule.Query
				labels = recordingRule.Labels.Labels
				annotations = nil // Recording rules don't have annotations
			} else {
				continue
			}

			sha256Hash := generateRuleSHA256(componentName, group.Name, ruleName, ruleType, query, labels, annotations)

			// Find existing debug info for this rule or create a new one
			var existingDebugInfo *rulespb.RuleDebugInfo
			for _, info := range debugInfo {
				if info.GroupName == group.Name && info.RuleName == ruleName {
					existingDebugInfo = info
					break
				}
			}

			if existingDebugInfo == nil {
				existingDebugInfo = &rulespb.RuleDebugInfo{
					GroupName:        group.Name,
					RuleName:         ruleName,
					RuleType:         ruleType,
					Query:            query,
					ComponentSha256S: []*rulespb.ComponentSha256{},
					Labels:           labelpb.ZLabelSet{Labels: labels},
					Annotations:      labelpb.ZLabelSet{Labels: annotations},
				}
				debugInfo = append(debugInfo, existingDebugInfo)
			}

			// Add SHA256 and actual rule content for this component
			existingDebugInfo.ComponentSha256S = append(existingDebugInfo.ComponentSha256S, &rulespb.ComponentSha256{
				Component:   componentName,
				Sha256:      sha256Hash,
				Query:       query,
				Labels:      labelpb.ZLabelSet{Labels: labels},
				Annotations: labelpb.ZLabelSet{Labels: annotations},
			})
		}
	}

	return debugInfo
}

// CollectRuleDebugInfoWithID collects debug information with component identifiers
func CollectRuleDebugInfoWithID(groups []*rulespb.RuleGroup, stage string, baseURL *url.URL) []*rulespb.RuleDebugInfo {
	componentID := getComponentIdentifier(stage, baseURL)
	return CollectRuleDebugInfo(groups, componentID)
}

// CollectMultiComponentDebugInfo collects debug information from multiple pipeline stages
func CollectMultiComponentDebugInfo(groups []*rulespb.RuleGroup, baseURL *url.URL) []*rulespb.RuleDebugInfo {
	var allDebugInfo []*rulespb.RuleDebugInfo

	stages := []string{
		"prometheus_fetch",
		"rules_manager_conversion",
		"querier_proxy_processing",
		"grpc_client_response",
		"query_api_handler",
	}

	// Collect debug information from each simulated component stage
	for _, stage := range stages {
		componentDebugInfo := CollectRuleDebugInfoWithID(groups, stage, baseURL)
		allDebugInfo = append(allDebugInfo, componentDebugInfo...)
	}

	return allDebugInfo
}

// DebugRuleGroups validates rule groups and logs issues (made public)
func DebugRuleGroups(logger log.Logger, groups []*rulespb.RuleGroup, stage, source string, baseURL *url.URL) {
	// Extract base URL information
	var urlInfo string
	if baseURL != nil {
		urlInfo = baseURL.String()
	} else {
		urlInfo = "unknown"
	}

	// Collect debug info and check for corruption
	debugInfo := CollectRuleDebugInfoWithID(groups, stage, baseURL)

	// Store debug info in global cache for rules debug endpoint access
	StoreDebugInfo(stage, debugInfo)

	for _, info := range debugInfo {
		corruptionDetails := DetectRuleCorruption(info)
		if len(corruptionDetails) > 0 {
			level.Error(logger).Log(
				"msg", "Rule corruption detected",
				"stage", stage,
				"source", source,
				"base_url", urlInfo,
				"rule", info.RuleName,
				"group", info.GroupName,
				"corruption_details", strings.Join(corruptionDetails, " | "),
			)
		}
	}

	for _, g := range groups {
		for _, r := range g.Rules {
			// Only check rule annotations (only for alerting rules)
			if alertRule := r.GetAlert(); alertRule != nil {
				if len(alertRule.Annotations.Labels) > 0 {
					for _, annotation := range alertRule.Annotations.Labels {
						// Generate SHA256 hash for this annotation entry
						sha256Key := generateAnnotationSHA256(stage, source, urlInfo, g.Name, alertRule.Name, annotation.Name, annotation.Value)

						// Check if this annotation combination already exists in cache
						if !annotationCache.Get(sha256Key) {
							// Add to cache and log the entry
							annotationCache.Put(sha256Key)
						}
					}
				}
			}
		}
	}
}

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

	DebugRuleGroups(p.logger, groups, "before_enrichment", p.base.String(), p.base)

	// Prometheus does not add external labels, so we need to add on our own.
	enrichRulesWithExtLabels(groups, p.extLabels())

	// Debug UTF-8 validation after enrichment
	DebugRuleGroups(p.logger, groups, "after_enrichment", p.base.String(), p.base)
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

// DetectRuleCorruption analyzes rule debug information to identify corrupted fields
func DetectRuleCorruption(debugInfo *rulespb.RuleDebugInfo) []string {
	var corruptions []string

	if len(debugInfo.ComponentSha256S) < 2 {
		return corruptions // Need at least 2 components to detect corruption
	}

	// Get reference hash from first component
	referenceHash := debugInfo.ComponentSha256S[0].Sha256
	referenceComponent := debugInfo.ComponentSha256S[0].Component

	// Check if any component has different hash
	hasCorruption := false
	var corruptedComponents []string

	for i := 1; i < len(debugInfo.ComponentSha256S); i++ {
		comp := debugInfo.ComponentSha256S[i]
		if comp.Sha256 != referenceHash {
			hasCorruption = true
			corruptedComponents = append(corruptedComponents, comp.Component)
		}
	}

	if !hasCorruption {
		return corruptions // No corruption detected
	}

	// Create detailed corruption report
	corruptions = append(corruptions, fmt.Sprintf("Rule corruption detected in %s:%s", debugInfo.GroupName, debugInfo.RuleName))
	corruptions = append(corruptions, fmt.Sprintf("Reference component %s has hash: %s", referenceComponent, referenceHash))

	for _, corruptedComp := range corruptedComponents {
		for _, comp := range debugInfo.ComponentSha256S {
			if comp.Component == corruptedComp {
				corruptions = append(corruptions, fmt.Sprintf("Component %s has different hash: %s", comp.Component, comp.Sha256))
				break
			}
		}
	}

	// Get detailed field comparison between components to identify specific corrupted fields
	detailedCorruption := DetectSpecificCorruptedFields(debugInfo)
	corruptions = append(corruptions, detailedCorruption...)

	return corruptions
}

// DetectSpecificCorruptedFields performs detailed field-by-field comparison to show exact differences
func DetectSpecificCorruptedFields(debugInfo *rulespb.RuleDebugInfo) []string {
	var details []string

	if len(debugInfo.ComponentSha256S) < 2 {
		return details
	}

	components := debugInfo.ComponentSha256S

	details = append(details, "=== Exact Field Differences Analysis ===")
	details = append(details, fmt.Sprintf("Rule: %s in group %s", debugInfo.RuleName, debugInfo.GroupName))

	// Compare each component against the previous one to find exact differences
	for i := 1; i < len(components); i++ {
		prevComp := components[i-1]
		currComp := components[i]

		if currComp.Sha256 != prevComp.Sha256 {
			details = append(details, "")
			details = append(details, fmt.Sprintf("🔍 CORRUPTION DETECTED between components %d → %d", i, i+1))
			details = append(details, fmt.Sprintf("From: %s (hash: %s)", parseComponentName(prevComp.Component), prevComp.Sha256[:16]+"..."))
			details = append(details, fmt.Sprintf("To:   %s (hash: %s)", parseComponentName(currComp.Component), currComp.Sha256[:16]+"..."))
			details = append(details, "")

			// Show exact field differences
			fieldDiffs := compareRuleFields(prevComp, currComp)
			if len(fieldDiffs) == 0 {
				details = append(details, "⚠️  No field differences detected - possible internal corruption")
			} else {
				details = append(details, "📝 EXACT FIELD DIFFERENCES:")
				for _, diff := range fieldDiffs {
					details = append(details, fmt.Sprintf("   %s", diff))
				}
			}
		}
	}

	return details
}

// GetFieldDifferences returns the specific field differences between components for API response
func GetFieldDifferences(debugInfo *rulespb.RuleDebugInfo) []string {
	var differences []string

	if len(debugInfo.ComponentSha256S) < 2 {
		return differences
	}

	components := debugInfo.ComponentSha256S

	// Compare each component against the previous one to find exact differences
	for i := 1; i < len(components); i++ {
		prevComp := components[i-1]
		currComp := components[i]

		if currComp.Sha256 != prevComp.Sha256 {
			// Show exact field differences
			fieldDiffs := compareRuleFields(prevComp, currComp)
			if len(fieldDiffs) > 0 {
				for _, diff := range fieldDiffs {
					differences = append(differences, diff)
				}
			}
		}
	}

	return differences
}

// compareRuleFields compares two ComponentSha256 structs field-by-field and returns exact differences
func compareRuleFields(prev, curr *rulespb.ComponentSha256) []string {
	var diffs []string

	// Compare query
	if prev.Query != curr.Query {
		diffs = append(diffs, fmt.Sprintf("Query: '%s' → '%s'", prev.Query, curr.Query))
	}

	// Compare labels
	labelDiffs := compareLabelSets(prev.Labels.Labels, curr.Labels.Labels, "Label")
	diffs = append(diffs, labelDiffs...)

	// Compare annotations
	annotationDiffs := compareLabelSets(prev.Annotations.Labels, curr.Annotations.Labels, "Annotation")
	diffs = append(diffs, annotationDiffs...)

	return diffs
}

// compareLabelSets compares two label sets and returns differences
func compareLabelSets(prev, curr []labelpb.ZLabel, fieldType string) []string {
	var diffs []string

	// Convert to maps for easier comparison
	prevMap := make(map[string]string)
	currMap := make(map[string]string)

	for _, label := range prev {
		prevMap[label.Name] = label.Value
	}

	for _, label := range curr {
		currMap[label.Name] = label.Value
	}

	// Find removed labels
	for name, value := range prevMap {
		if _, exists := currMap[name]; !exists {
			if name == "replica" {
				diffs = append(diffs, fmt.Sprintf("%s REMOVED (EXPECTED): %s=%s - replica labels are normally removed during deduplication", fieldType, name, value))
			} else {
				diffs = append(diffs, fmt.Sprintf("%s REMOVED: %s=%s", fieldType, name, value))
			}
		}
	}

	// Find added labels
	for name, value := range currMap {
		if _, exists := prevMap[name]; !exists {
			if name == "replica" {
				diffs = append(diffs, fmt.Sprintf("%s ADDED (EXPECTED): %s=%s - replica labels can be added during processing", fieldType, name, value))
			} else {
				diffs = append(diffs, fmt.Sprintf("%s ADDED: %s=%s", fieldType, name, value))
			}
		}
	}

	// Find changed labels
	for name, currValue := range currMap {
		if prevValue, exists := prevMap[name]; exists && prevValue != currValue {
			if name == "replica" {
				diffs = append(diffs, fmt.Sprintf("%s CHANGED (EXPECTED): %s='%s' → '%s' - replica label changes are normal", fieldType, name, prevValue, currValue))
			} else {
				diffs = append(diffs, fmt.Sprintf("%s CHANGED: %s='%s' → '%s'", fieldType, name, prevValue, currValue))
			}
		}
	}

	return diffs
}

// generateFieldSHA256 creates a SHA256 hash for a specific field
func generateFieldSHA256(fieldName, fieldValue string) string {
	data := fmt.Sprintf("%s:%s", fieldName, fieldValue)
	hash := sha256.Sum256([]byte(data))
	return fmt.Sprintf("%x", hash)
}

// labelsToString converts label array to a consistent string representation
func labelsToString(labels []labelpb.ZLabel) string {
	if len(labels) == 0 {
		return ""
	}

	var pairs []string
	for _, label := range labels {
		pairs = append(pairs, fmt.Sprintf("%s=%s", label.Name, label.Value))
	}
	return strings.Join(pairs, ",")
}

// parseComponentName extracts a human-readable component name from the full component identifier
func parseComponentName(fullComponent string) string {
	// Format: hostname_file_function_line_stage_url
	parts := strings.Split(fullComponent, "_")
	if len(parts) < 5 {
		return fullComponent
	}

	file := parts[1]
	function := parts[2]
	stage := strings.Join(parts[4:], "_")

	// Remove .go extension for cleaner display
	if strings.HasSuffix(file, ".go") {
		file = file[:len(file)-3]
	}

	return fmt.Sprintf("%s:%s [%s]", file, function, stage)
}

// getCorruptionGuidance provides specific troubleshooting guidance based on where corruption occurred
func getCorruptionGuidance(fromComponent, toComponent string) []string {
	var guidance []string

	fromStage := extractStage(fromComponent)
	toStage := extractStage(toComponent)

	// Provide specific guidance based on pipeline transition
	switch {
	case strings.Contains(fromStage, "proxy") && strings.Contains(toStage, "grpc"):
		guidance = append(guidance, "Check query proxy filtering/transformation logic")
		guidance = append(guidance, "Verify gRPC client deduplication is not modifying rule content")
		guidance = append(guidance, "Check if matchers or filters are altering rules unexpectedly")

	case strings.Contains(fromStage, "prometheus") && strings.Contains(toStage, "manager"):
		guidance = append(guidance, "Check Prometheus API response parsing")
		guidance = append(guidance, "Verify rules manager proto conversion logic")
		guidance = append(guidance, "Look for encoding/UTF-8 issues in rule content")

	case strings.Contains(fromStage, "manager") && strings.Contains(toStage, "proxy"):
		guidance = append(guidance, "Check rules manager serialization")
		guidance = append(guidance, "Verify proxy rule forwarding logic")
		guidance = append(guidance, "Look for gRPC streaming issues")

	default:
		guidance = append(guidance, "Check for data transformation between these components")
		guidance = append(guidance, "Verify serialization/deserialization logic")
		guidance = append(guidance, "Look for encoding or character set issues")
	}

	guidance = append(guidance, "Enable debug logging in both components for detailed analysis")
	return guidance
}

// extractStage extracts the stage information from component identifier
func extractStage(component string) string {
	parts := strings.Split(component, "_")
	if len(parts) >= 5 {
		return strings.Join(parts[4:], "_")
	}
	return component
}

// CollectAllComponentDebugInfo collects debug information from all components that have processed rules
// This function aggregates debug info from the global cache maintained by different processing stages
func CollectAllComponentDebugInfo(groups []*rulespb.RuleGroup) []*rulespb.RuleDebugInfo {
	var allDebugInfo []*rulespb.RuleDebugInfo

	components := []string{
		"promclient_after_fetch",
		"rules_manager_after_proto_conversion",
		"querier_proxy_before_send",
		"grpc_client_after_proxy",
		"query_api_before_response",
	}

	// Collect debug information from each component stage
	for _, component := range components {
		componentDebugInfo := CollectRuleDebugInfo(groups, component)
		allDebugInfo = append(allDebugInfo, componentDebugInfo...)
	}

	return allDebugInfo
}
