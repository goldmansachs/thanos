package main

import (
	"context"
	"crypto/tls"
	"flag"
	"fmt"
	"io"
	"log"
	"net/url"
	"strings"
	"time"

	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
	"google.golang.org/grpc/credentials/insecure"
	
	// Thanos protobuf generated files - you'll need to generate these
	// from the Thanos proto files or use the Thanos client
	rulespb "github.com/thanos-io/thanos/pkg/rules/rulespb"
)

type Config struct {
	URL       string
	Timeout   time.Duration
	Insecure  bool
	PlainText bool
}

func main() {
	var cfg Config
	
	flag.StringVar(&cfg.URL, "url", "", "Thanos Rules gRPC URL (e.g., localhost:10904)")
	flag.DurationVar(&cfg.Timeout, "timeout", 30*time.Second, "Request timeout")
	flag.BoolVar(&cfg.Insecure, "insecure", false, "Skip TLS verification")
	flag.BoolVar(&cfg.PlainText, "plaintext", false, "Use plaintext connection (no TLS)")
	flag.Parse()

	if cfg.URL == "" {
		log.Fatal("URL is required. Use -url flag to specify Thanos Rules endpoint")
	}

	// Parse and clean URL
	endpoint := cleanURL(cfg.URL)
	
	// Create gRPC connection
	conn, err := createConnection(endpoint, cfg)
	if err != nil {
		log.Fatalf("Failed to connect to %s: %v", endpoint, err)
	}
	defer conn.Close()

	// Create Rules client
	client := rulespb.NewRulesClient(conn)

	// Query rules
	if err := queryAndDisplayRules(client, cfg.Timeout); err != nil {
		log.Fatalf("Failed to query rules: %v", err)
	}
}

func cleanURL(rawURL string) string {
	// Remove protocol if present
	if strings.HasPrefix(rawURL, "http://") {
		rawURL = strings.TrimPrefix(rawURL, "http://")
	}
	if strings.HasPrefix(rawURL, "https://") {
		rawURL = strings.TrimPrefix(rawURL, "https://")
	}
	
	// Parse URL to extract host:port
	if u, err := url.Parse("dummy://" + rawURL); err == nil {
		if u.Port() != "" {
			return u.Host
		}
		// Default port for Thanos Rules
		return u.Hostname() + ":10904"
	}
	
	return rawURL
}

func createConnection(endpoint string, cfg Config) (*grpc.ClientConn, error) {
	var opts []grpc.DialOption

	if cfg.PlainText {
		opts = append(opts, grpc.WithTransportCredentials(insecure.NewCredentials()))
	} else {
		tlsConfig := &tls.Config{
			InsecureSkipVerify: cfg.Insecure,
		}
		opts = append(opts, grpc.WithTransportCredentials(credentials.NewTLS(tlsConfig)))
	}

	// Set timeout
	ctx, cancel := context.WithTimeout(context.Background(), cfg.Timeout)
	defer cancel()

	conn, err := grpc.DialContext(ctx, endpoint, opts...)
	if err != nil {
		return nil, fmt.Errorf("failed to dial %s: %w", endpoint, err)
	}

	return conn, nil
}

func queryAndDisplayRules(client rulespb.RulesClient, timeout time.Duration) error {
	ctx, cancel := context.WithTimeout(context.Background(), timeout)
	defer cancel()

	// Query rules - this returns a stream
	req := &rulespb.RulesRequest{
		Type: rulespb.RulesRequest_ALL,
	}

	stream, err := client.Rules(ctx, req)
	if err != nil {
		return fmt.Errorf("failed to get rules stream: %w", err)
	}

	// Collect all rule groups from the stream
	var allGroups []*rulespb.RuleGroup
	var warnings []string

	for {
		resp, err := stream.Recv()
		if err != nil {
			if err == io.EOF {
				break // End of stream
			}
			return fmt.Errorf("failed to receive from stream: %w", err)
		}

		// Handle the response based on its type
		switch result := resp.Result.(type) {
		case *rulespb.RulesResponse_Group:
			allGroups = append(allGroups, result.Group)
		case *rulespb.RulesResponse_Warning:
			warnings = append(warnings, result.Warning)
		}
	}

	// Display results as plaintext
	displayRulesAsPlaintext(allGroups, warnings)
	
	return nil
}

func displayRulesAsPlaintext(groups []*rulespb.RuleGroup, warnings []string) {
	fmt.Println("=== THANOS RULES ===")
	
	// Display warnings if any
	if len(warnings) > 0 {
		fmt.Println("Warnings:")
		for _, warning := range warnings {
			fmt.Printf("  - %s\n", warning)
		}
		fmt.Println()
	}
	
	fmt.Printf("Status: success\n")
	fmt.Printf("Total Groups: %d\n", len(groups))
	fmt.Println()

	if len(groups) == 0 {
		fmt.Println("No rule groups found.")
		return
	}

	for i, group := range groups {
		fmt.Printf("--- Rule Group %d ---\n", i+1)
		fmt.Printf("Name: %s\n", group.Name)
		fmt.Printf("File: %s\n", group.File)
		fmt.Printf("Interval: %.0fs\n", group.Interval)
		fmt.Printf("Rules Count: %d\n", len(group.Rules))
		
		if !group.LastEvaluation.IsZero() {
			fmt.Printf("Last Evaluation: %s\n", group.LastEvaluation.Format(time.RFC3339))
		}
		
		if group.EvaluationDurationSeconds > 0 {
			fmt.Printf("Evaluation Time: %.3fs\n", group.EvaluationDurationSeconds)
		}
		
		fmt.Println()
		
		// Display individual rules
		for j, rule := range group.Rules {
			fmt.Printf("  Rule %d:\n", j+1)
			
			// Handle different rule types (Recording vs Alert)
			switch ruleType := rule.Result.(type) {
			case *rulespb.Rule_Recording:
				recording := ruleType.Recording
				fmt.Printf("    Name: %s\n", recording.Name)
				fmt.Printf("    Type: recording\n")
				fmt.Printf("    Query: %s\n", recording.Query)
				fmt.Printf("    Health: %s\n", recording.Health)
				
				if recording.LastError != "" {
					fmt.Printf("    Last Error: %s\n", recording.LastError)
				}
				
				if !recording.LastEvaluation.IsZero() {
					fmt.Printf("    Last Evaluation: %s\n", recording.LastEvaluation.Format(time.RFC3339))
				}
				
				if recording.EvaluationDurationSeconds > 0 {
					fmt.Printf("    Evaluation Time: %.3fs\n", recording.EvaluationDurationSeconds)
				}
				
				// Display labels
				if len(recording.Labels.Labels) > 0 {
					fmt.Printf("    Labels:\n")
					for _, label := range recording.Labels.Labels {
						fmt.Printf("      %s: %s\n", label.Name, label.Value)
					}
				}
				
			case *rulespb.Rule_Alert:
				alert := ruleType.Alert
				fmt.Printf("    Name: %s\n", alert.Name)
				fmt.Printf("    Type: alerting\n")
				fmt.Printf("    Query: %s\n", alert.Query)
				fmt.Printf("    Health: %s\n", alert.Health)
				fmt.Printf("    State: %s\n", alert.State.String())
				fmt.Printf("    Duration: %.0fs\n", alert.DurationSeconds)
				
				if alert.LastError != "" {
					fmt.Printf("    Last Error: %s\n", alert.LastError)
				}
				
				if !alert.LastEvaluation.IsZero() {
					fmt.Printf("    Last Evaluation: %s\n", alert.LastEvaluation.Format(time.RFC3339))
				}
				
				if alert.EvaluationDurationSeconds > 0 {
					fmt.Printf("    Evaluation Time: %.3fs\n", alert.EvaluationDurationSeconds)
				}
				
				// Display labels
				if len(alert.Labels.Labels) > 0 {
					fmt.Printf("    Labels:\n")
					for _, label := range alert.Labels.Labels {
						fmt.Printf("      %s: %s\n", label.Name, label.Value)
					}
				}
				
				// Display annotations
				if len(alert.Annotations.Labels) > 0 {
					fmt.Printf("    Annotations:\n")
					for _, annotation := range alert.Annotations.Labels {
						fmt.Printf("      %s: %s\n", annotation.Name, annotation.Value)
					}
				}
				
				// Display alert instances
				if len(alert.Alerts) > 0 {
					fmt.Printf("    Active Alerts: %d\n", len(alert.Alerts))
					for k, instance := range alert.Alerts {
						fmt.Printf("      Alert %d:\n", k+1)
						fmt.Printf("        State: %s\n", instance.State.String())
						fmt.Printf("        Value: %s\n", instance.Value)
						if !instance.ActiveAt.IsZero() {
							fmt.Printf("        Active At: %s\n", instance.ActiveAt.Format(time.RFC3339))
						}
					}
				}
			}
			
			fmt.Println()
		}
		
		fmt.Println("----------------------------------------")
		fmt.Println()
	}
	
	totalRules := 0
	for _, group := range groups {
		totalRules += len(group.Rules)
	}
	fmt.Printf("Total: %d groups with %d rules\n", len(groups), totalRules)
}
