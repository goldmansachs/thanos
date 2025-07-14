package main

import (
	"crypto/tls"
	"encoding/json"
	"flag"
	"fmt"
	"log"
	"net/http"
	"os/exec"
	"strings"
	"time"
)

type Config struct {
	URL       string
	Timeout   time.Duration
	Insecure  bool
	PlainText bool
	Method    string
}

type Rule struct {
	Name            string            `json:"name"`
	Query           string            `json:"query"`
	Type            string            `json:"type"`
	Health          string            `json:"health"`
	LastError       string            `json:"lastError,omitempty"`
	LastEvaluation  string            `json:"lastEvaluation,omitempty"`
	EvaluationTime  string            `json:"evaluationTime,omitempty"`
	Labels          map[string]string `json:"labels,omitempty"`
	Annotations     map[string]string `json:"annotations,omitempty"`
}

type RuleGroup struct {
	Name           string  `json:"name"`
	File           string  `json:"file"`
	Interval       string  `json:"interval"`
	Rules          []Rule  `json:"rules"`
	LastEvaluation string  `json:"lastEvaluation,omitempty"`
	EvaluationTime string  `json:"evaluationTime,omitempty"`
}

type RulesResponse struct {
	Status string `json:"status"`
	Data   struct {
		Groups []RuleGroup `json:"groups"`
	} `json:"data"`
}

func main() {
	var cfg Config
	
	flag.StringVar(&cfg.URL, "url", "", "Thanos Rules endpoint URL")
	flag.DurationVar(&cfg.Timeout, "timeout", 30*time.Second, "Request timeout")
	flag.BoolVar(&cfg.Insecure, "insecure", false, "Skip TLS verification")
	flag.BoolVar(&cfg.PlainText, "plaintext", false, "Use HTTP instead of HTTPS")
	flag.StringVar(&cfg.Method, "method", "http", "Query method: 'http' or 'grpc'")
	flag.Parse()

	if cfg.URL == "" {
		log.Fatal("URL is required. Use -url flag to specify Thanos Rules endpoint")
	}

	switch cfg.Method {
	case "http":
		if err := queryRulesHTTP(cfg); err != nil {
			log.Fatalf("HTTP query failed: %v", err)
		}
	case "grpc":
		if err := queryRulesGRPC(cfg); err != nil {
			log.Fatalf("gRPC query failed: %v", err)
		}
	default:
		log.Fatal("Invalid method. Use 'http' or 'grpc'")
	}
}

func queryRulesHTTP(cfg Config) error {
	// Build URL
	scheme := "https"
	if cfg.PlainText {
		scheme = "http"
	}
	
	baseURL := cfg.URL
	if !strings.HasPrefix(baseURL, "http") {
		baseURL = fmt.Sprintf("%s://%s", scheme, baseURL)
	}
	
	rulesURL := fmt.Sprintf("%s/api/v1/rules", strings.TrimSuffix(baseURL, "/"))
	
	// Create HTTP client
	client := &http.Client{
		Timeout: cfg.Timeout,
		Transport: &http.Transport{
			TLSClientConfig: &tls.Config{
				InsecureSkipVerify: cfg.Insecure,
			},
		},
	}
	
	// Make request
	resp, err := client.Get(rulesURL)
	if err != nil {
		return fmt.Errorf("failed to make HTTP request: %w", err)
	}
	defer resp.Body.Close()
	
	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("HTTP request failed with status: %d", resp.StatusCode)
	}
	
	// Parse response
	var rulesResp RulesResponse
	if err := json.NewDecoder(resp.Body).Decode(&rulesResp); err != nil {
		return fmt.Errorf("failed to decode response: %w", err)
	}
	
	// Display results
	displayRulesPlaintext(rulesResp)
	return nil
}

func queryRulesGRPC(cfg Config) error {
	// Use grpcurl to query gRPC endpoint
	endpoint := cfg.URL
	if !strings.Contains(endpoint, ":") {
		endpoint += ":10904" // Default Thanos Rules gRPC port
	}
	
	args := []string{
		"-d", `{"type": 0}`, // ALL rules type
		"-format", "json",
	}
	
	if cfg.PlainText {
		args = append(args, "-plaintext")
	}
	
	if cfg.Insecure {
		args = append(args, "-insecure")
	}
	
	args = append(args, endpoint, "thanos.Rules/Rules")
	
	cmd := exec.Command("grpcurl", args...)
	output, err := cmd.Output()
	if err != nil {
		return fmt.Errorf("grpcurl command failed: %w\nTry installing grpcurl: go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest", err)
	}
	
	// Parse and display the raw gRPC response
	fmt.Println("=== THANOS RULES (gRPC Response) ===")
	fmt.Printf("Raw gRPC Response:\n%s\n", string(output))
	
	return nil
}

func displayRulesPlaintext(resp RulesResponse) {
	fmt.Println("=== THANOS RULES ===")
	fmt.Printf("Status: %s\n", resp.Status)
	fmt.Printf("Total Groups: %d\n", len(resp.Data.Groups))
	fmt.Println()

	for i, group := range resp.Data.Groups {
		fmt.Printf("--- Rule Group %d ---\n", i+1)
		fmt.Printf("Name: %s\n", group.Name)
		fmt.Printf("File: %s\n", group.File)
		fmt.Printf("Interval: %s\n", group.Interval)
		fmt.Printf("Rules Count: %d\n", len(group.Rules))
		
		if group.LastEvaluation != "" {
			fmt.Printf("Last Evaluation: %s\n", group.LastEvaluation)
		}
		
		if group.EvaluationTime != "" {
			fmt.Printf("Evaluation Time: %s\n", group.EvaluationTime)
		}
		
		fmt.Println()
		
		// Display individual rules
		for j, rule := range group.Rules {
			fmt.Printf("  Rule %d:\n", j+1)
			fmt.Printf("    Name: %s\n", rule.Name)
			fmt.Printf("    Query: %s\n", rule.Query)
			fmt.Printf("    Type: %s\n", rule.Type)
			fmt.Printf("    Health: %s\n", rule.Health)
			
			if rule.LastError != "" {
				fmt.Printf("    Last Error: %s\n", rule.LastError)
			}
			
			if rule.LastEvaluation != "" {
				fmt.Printf("    Last Evaluation: %s\n", rule.LastEvaluation)
			}
			
			if rule.EvaluationTime != "" {
				fmt.Printf("    Evaluation Time: %s\n", rule.EvaluationTime)
			}
			
			// Display labels
			if len(rule.Labels) > 0 {
				fmt.Printf("    Labels:\n")
				for key, value := range rule.Labels {
					fmt.Printf("      %s: %s\n", key, value)
				}
			}
			
			// Display annotations
			if len(rule.Annotations) > 0 {
				fmt.Printf("    Annotations:\n")
				for key, value := range rule.Annotations {
					fmt.Printf("      %s: %s\n", key, value)
				}
			}
			
			fmt.Println()
		}
		
		fmt.Println("----------------------------------------")
		fmt.Println()
	}
	
	fmt.Printf("Total rules displayed: %d groups\n", len(resp.Data.Groups))
}
