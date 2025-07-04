// Copyright (c) The Thanos Authors.
// Licensed under the Apache License 2.0.

package rules

import (
	"crypto/sha256"
	"fmt"
	"net/url"
	"strings"
	"sync"

	"github.com/go-kit/log"
	"github.com/go-kit/log/level"
	"github.com/prometheus/prometheus/model/labels"

	"github.com/thanos-io/thanos/pkg/promclient"
	"github.com/thanos-io/thanos/pkg/rules/rulespb"
	"github.com/thanos-io/thanos/pkg/store/labelpb"
)

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

// generateAnnotationSHA256 creates a SHA256 hash for the annotation debug entry
func generateAnnotationSHA256(stage, source, baseURL, group, alert, annotationKey, annotationValue string) string {
	data := fmt.Sprintf("%s|%s|%s|%s|%s|%s|%s", stage, source, baseURL, group, alert, annotationKey, annotationValue)
	hash := sha256.Sum256([]byte(data))
	return fmt.Sprintf("%x", hash)
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

							level.Debug(logger).Log(
								"msg", "ANNOTATION DEBUG",
								"stage", stage,
								"source", source,
								"base_url", urlInfo,
								"group", g.Name,
								"alert", alertRule.Name,
								"annotation_key", annotation.Name,
								"annotation_value", annotation.Value,
								"annotation_key_hex", []byte(annotation.Name),
								"annotation_value_hex", []byte(annotation.Value),
								"sha256", sha256Key,
							)
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

	// Debug UTF-8 validation before enrichment
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
