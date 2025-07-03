#!/usr/bin/env python3

"""
Script: prepare_repo.py
Usage: python3 prepare_repo.py <branch_name> <from_ref> <to_ref> [--base_commit <commit>] [--repo_type <type>]

Enhanced patch and apply workflow with better conflict resolution
"""

import os
import sys
import subprocess
import shutil
import tempfile
import re
from pathlib import Path
from datetime import datetime
import argparse

# Repository mappings: upstream -> goldman sachs fork
REPO_MAPPINGS = {
    "thanos": {
        "upstream": "git@github.com:thanos-io/thanos.git",
        "gs": "git@github.com:goldmansachs/thanos.git"
    },
    "prometheus": {
        "upstream": "git@github.com:prometheus/prometheus.git",
        "gs": "git@github.com:goldmansachs/prometheus.git"
    },
    "common": {
        "upstream": "git@github.com:prometheus/common.git",
        "gs": "git@github.com:goldmansachs/common.git"
    },
    "alertmanager": {
        "upstream": "git@github.com:prometheus/alertmanager.git",
        "gs": "git@github.com:goldmansachs/alertmanager.git"
    }
}

# File filters based on repository type
FILE_FILTERS = {
    "thanos": {
        "include": r"\.(go|tsx|ts|js|yaml|yml|json|md|proto)$",
        "exclude": r"(BUILD|\.gz$|\.svg$|\.png$|\.jpg$|\.bazel$|WORKSPACE$|go\.sum$|\.bzl$|vendor/|\.pb\.go$)"
    },
    "prometheus": {
        "include": r"\.(go|tsx|ts|js|yaml|yml|json|md|proto)$",
        "exclude": r"(BUILD|\.gz$|\.svg$|\.png$|\.jpg$|\.bazel$|WORKSPACE$|go\.sum$|\.bzl$|vendor/|\.pb\.go$)"
    },
    "alertmanager": {
        "include": r"\.(go|tsx|ts|js|yaml|yml|json|md|proto)$",
        "exclude": r"(BUILD|\.gz$|\.svg$|\.png$|\.jpg$|\.bazel$|WORKSPACE$|go\.sum$|\.bzl$|vendor/|\.pb\.go$)"
    },
    "common": {
        "include": r"\.(go|tsx|ts|js|yaml|yml|json|md)$",
        "exclude": r"(BUILD|\.gz$|\.svg$|\.png$|\.jpg$|\.bazel$|WORKSPACE$|go\.sum$|\.bzl$)"
    }
}

class Colors:
    """ANSI color codes for better output"""
    BLUE = '\033[94m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    PURPLE = '\033[95m'
    CYAN = '\033[96m'
    BOLD = '\033[1m'
    END = '\033[0m'

def run_command(cmd, cwd=None, check=True, capture_output=True):
    """Run a shell command with better error handling"""
    try:
        if isinstance(cmd, str):
            cmd = cmd.split()
        
        result = subprocess.run(
            cmd, 
            cwd=cwd, 
            check=check, 
            capture_output=capture_output,
            text=True
        )
        return result
    except subprocess.CalledProcessError as e:
        if capture_output:
            print(f"{Colors.RED}❌ Command failed: {' '.join(cmd)}{Colors.END}")
            print(f"{Colors.RED}Error: {e.stderr}{Colors.END}")
        raise

def print_header(title):
    """Print a formatted header"""
    print(f"\n{Colors.BOLD}{'='*50}{Colors.END}")
    print(f"{Colors.BOLD}{title}{Colors.END}")
    print(f"{Colors.BOLD}{'='*50}{Colors.END}")

def print_step(step, message):
    """Print a formatted step"""
    print(f"\n{Colors.CYAN}Step {step}: {message}{Colors.END}")

def print_success(message):
    """Print a success message"""
    print(f"{Colors.GREEN}✓ {message}{Colors.END}")

def print_warning(message):
    """Print a warning message"""
    print(f"{Colors.YELLOW}⚠ {message}{Colors.END}")

def print_error(message):
    """Print an error message"""
    print(f"{Colors.RED}❌ {message}{Colors.END}")

def show_repo_types():
    """Show available repository types"""
    print("Available repository types:")
    for repo_type, urls in REPO_MAPPINGS.items():
        print(f"  {repo_type}:")
        print(f"    Upstream: {urls['upstream']}")
        print(f"    Goldman Sachs: {urls['gs']}")

def detect_repo_type():
    """Auto-detect repository type from current directory or git remotes"""
    # Try to detect from current directory name
    current_dir = Path.cwd().name
    for repo_type in REPO_MAPPINGS.keys():
        if repo_type in current_dir:
            return repo_type
    
    # Try to detect from git remote if we're in a git repo
    try:
        result = run_command("git remote -v")
        remotes = result.stdout
        
        if "prometheus/prometheus" in remotes:
            return "prometheus"
        elif "prometheus/common" in remotes:
            return "common"
        elif "prometheus/alertmanager" in remotes:
            return "alertmanager"
        elif "thanos-io/thanos" in remotes:
            return "thanos"
    except:
        pass
    
    # Default fallback
    return "common"

def get_repo_urls(repo_type):
    """Get repository URLs for the given type"""
    if repo_type not in REPO_MAPPINGS:
        print_error(f"Unknown repository type: {repo_type}")
        show_repo_types()
        sys.exit(1)
    
    return REPO_MAPPINGS[repo_type]

def setup_git_merge_config(repo_path):
    """Set up better git merge configuration"""
    print("Setting up enhanced git merge configuration...")
    
    configs = [
        ["git", "config", "merge.conflictstyle", "diff3"],
        ["git", "config", "merge.tool.trustExitCode", "true"],
        ["git", "config", "mergetool.keepBackup", "false"],
        ["git", "config", "merge.tool.prompt", "false"]
    ]
    
    for config in configs:
        try:
            run_command(config, cwd=repo_path, check=False)
        except:
            pass
    
    print_success("Enhanced git merge configuration applied")
    print("  - Conflict style: diff3 (shows base/local/remote)")
    print("  - No backup files (.orig)")
    print("  - No prompts for each file")

def detect_diff_tools():
    """Detect available diff tools"""
    tools = []
    
    tool_commands = {
        "code": ["code", "--version"],
        "meld": ["meld", "--version"],
        "kdiff3": ["kdiff3", "--version"],
        "opendiff": ["opendiff"],  # macOS
        "vimdiff": ["vim", "--version"]
    }
    
    for tool, cmd in tool_commands.items():
        try:
            run_command(cmd, capture_output=True, check=False)
            tools.append(tool)
        except:
            pass
    
    # Check for git mergetool
    try:
        run_command("git config --get merge.tool", check=False)
        tools.append("git-mergetool")
    except:
        # Check if we have tools that git mergetool can use
        if any(tool in tools for tool in ["meld", "kdiff3", "opendiff", "code"]):
            tools.append("git-mergetool")
    
    return tools

def resolve_reference(ref, repo_path):
    """Resolve reference to full remote path"""
    print(f"🔍 Resolving reference: {ref}")
    
    if ref.startswith("goldmansachs/"):
        # This is a Goldman Sachs reference - should look in origin remote
        clean_ref = ref.replace("goldmansachs/", "")
        print(f"   Checking Goldman Sachs reference: {clean_ref}")
        
        # First check if it's a branch in origin
        try:
            run_command(f"git show-ref --verify --quiet refs/remotes/origin/{clean_ref}", cwd=repo_path)
            print(f"   Found as origin branch: origin/{clean_ref}")
            return f"origin/{clean_ref}"
        except:
            pass
        
        # Then check if it's a local tag
        try:
            run_command(f"git show-ref --verify --quiet refs/tags/{clean_ref}", cwd=repo_path)
            print(f"   Found as local tag: {clean_ref}")
            return clean_ref
        except:
            pass
        
        # Default to origin branch
        print(f"   Defaulting to origin branch: origin/{clean_ref}")
        return f"origin/{clean_ref}"
    else:
        # This is a regular reference - check upstream first for tags, then remotes
        print(f"   Checking regular reference: {ref}")
        
        # First check if it's a tag
        try:
            run_command(f"git show-ref --verify --quiet refs/tags/{ref}", cwd=repo_path)
            print(f"   Found as tag: {ref}")
            return ref
        except:
            pass
        
        # Then check upstream remote
        try:
            run_command(f"git show-ref --verify --quiet refs/remotes/upstream/{ref}", cwd=repo_path)
            print(f"   Found as upstream branch: upstream/{ref}")
            return f"upstream/{ref}"
        except:
            pass
        
        # Then check origin remote
        try:
            run_command(f"git show-ref --verify --quiet refs/remotes/origin/{ref}", cwd=repo_path)
            print(f"   Found as origin branch: origin/{ref}")
            return f"origin/{ref}"
        except:
            pass
        
        # Default to upstream
        print(f"   Defaulting to upstream: upstream/{ref}")
        return f"upstream/{ref}"

def get_conflicted_files(repo_path):
    """Get list of files with conflicts"""
    try:
        result = run_command("git diff --name-only --diff-filter=U", cwd=repo_path)
        files = [f.strip() for f in result.stdout.split('\n') if f.strip()]
        if not files:
            # Try alternative method
            result = run_command("git status --porcelain", cwd=repo_path)
            for line in result.stdout.split('\n'):
                if line.startswith(('UU', 'AA', 'DD')):
                    files.append(line[3:].strip())
        return files
    except:
        return []

def count_conflict_markers(file_path):
    """Count conflict markers in a file"""
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
        return len(re.findall(r'^(<<<<<<<|=======|>>>>>>>)', content, re.MULTILINE))
    except:
        return 0

def show_conflict_preview(file_path, max_lines=6):
    """Show a preview of conflicts in a file"""
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            lines = f.readlines()
        
        conflict_lines = []
        for i, line in enumerate(lines, 1):
            if re.match(r'^<<<<<<<', line):
                # Include line before, the conflict marker, and line after
                start = max(0, i-2)
                end = min(len(lines), i+1)
                for j in range(start, end):
                    conflict_lines.append(f"{j+1:4}: {lines[j].rstrip()}")
                if len(conflict_lines) >= max_lines:
                    break
        
        return conflict_lines[:max_lines]
    except:
        return ["(unable to preview)"]

def use_diff_tool_enhanced(tool, merged_file, local_file, remote_file, base_file, context):
    """Use enhanced diff tool for conflict resolution with 3-way merge"""
    print(f"🔧 Using enhanced {tool} workflow for: {Path(merged_file).name})")
    print()
    
    if tool == "code":
        print("🚀 VS Code 3-Way Merge")
        print("======================")
        print("Opening 3-way merge editor in VS Code.")
        print("Your goal is to resolve conflicts in the 'Result' view at the bottom.")
        print()
        print("🔀 File Legend:")
        print(f"  - Incoming (Left): Changes from the patch ({context['to_ref']})")
        print(f"  - Current (Right): Your version on branch '{context['branch_name']}'")
        print(f"  - Base (Ancestor): Common ancestor from '{context['from_ref']}'")
        print()
        
        # VS Code merge command: code --merge <remote> <local> <base> <result>
        # Note the order: remote is "theirs", local is "ours".
        print("Opening files in VS Code...")
        try:
            # The order for VS Code is: remote, local, base, result
            # remote: incoming patch (theirs)
            # local: current branch (ours)
            # base: common ancestor
            # result: file with conflicts to be resolved
            result = run_command([
                "code", "--wait", "--merge", remote_file, local_file, base_file, merged_file
            ], check=False, capture_output=True) # capture output to check for errors
            
            if result.returncode == 0:
                print_success("VS Code merge session completed.")
            else:
                print_warning("VS Code merge command returned a non-zero exit code.")
                print_warning("This might be okay if you saved the file.")
                print_warning("If conflicts are not resolved, you may need to run it again or use another tool.")
                if result.stderr:
                    print(f"VS Code stderr:\n{result.stderr}")

        except Exception as e:
            print_error(f"Failed to open VS Code for merging: {e}")
            print_warning("Falling back to opening the conflicted file directly.")
            try:
                run_command(['code', '--wait', merged_file], capture_output=False)
            except Exception as e2:
                print_error(f"Fallback to open with VS Code also failed: {e2}")
                return False

    elif tool == "git-mergetool":
        print("🚀 Enhanced Git Mergetool Resolution")
        print("====================================")
        print()
        print("🔀 Git Mergetool Enhanced File Legend:")
        print("════════════════════════════════════════")
        print(f"📄 BASE (ancestor):   Original from {context['from_ref']}")
        print(f"📄 LOCAL (ours):      Your current branch ({context['branch_name']})")
        print(f"📄 REMOTE (theirs):   Incoming from patch ({context['to_ref']})")
        print(f"📄 MERGED (result):   Final resolved file (what you're editing)")
        print()
        print("🎯 MERGE CONTEXT:")
        print(f"  Source: {context['to_ref']} → Target: {context['branch_name']}")
        print(f"  File: {merged_file}")
        print()
        
        # Configure git mergetool if not configured
        try:
            run_command("git config --get merge.tool", cwd=context['repo_path'])
        except:
            print("Git mergetool not configured. Setting up...")
            print()
            
            # Try to auto-configure a suitable merge tool
            if shutil.which("meld"):
                print("Configuring git to use meld")
                run_command("git config merge.tool meld", cwd=context['repo_path'])
            elif shutil.which("kdiff3"):
                print("Configuring git to use kdiff3")
                run_command("git config merge.tool kdiff3", cwd=context['repo_path'])
            elif shutil.which("code"):
                print("Configuring git to use VS Code")
                run_command("git config merge.tool vscode", cwd=context['repo_path'])
                run_command(['git', 'config', 'mergetool.vscode.cmd', 
                           'code --wait --merge "$REMOTE" "$LOCAL" "$BASE" "$MERGED"'],
                          cwd=context['repo_path'])
            else:
                print_error("No suitable merge tool found for git mergetool")
                return False
        
        # Show which tool git will use
        try:
            result = run_command("git config --get merge.tool", cwd=context['repo_path'])
            configured_tool = result.stdout.strip()
            print(f"🔧 Git mergetool is configured to use: {configured_tool}")
        except:
            pass
        
        print()
        print(f"📝 File being merged: {merged_file}")
        print(f"🔀 Merging: {context['to_ref']} → {context['branch_name']}")
        print()
        input("Press Enter to open git mergetool...")
        
        # Use git mergetool for this specific file
        print(f"Opening git mergetool for {merged_file}...")
        print()
        
        try:
            result = run_command(f"git mergetool {merged_file}", 
                               cwd=context['repo_path'], capture_output=False)
            
            print()
            print_success(f"Git mergetool completed for {merged_file}")
            
            # Clean up .orig files
            orig_file = Path(context['repo_path']) / f"{merged_file}.orig"
            if orig_file.exists():
                print(f"🧹 Removing backup file: {orig_file.name}")
                orig_file.unlink()
            
            # Check if conflict markers still exist
            if count_conflict_markers(Path(context['repo_path']) / merged_file) > 0:
                print_warning(f"Conflict markers still found in {merged_file}")
                response = input("Continue anyway? (y/N): ").strip().lower()
                if response != 'y':
                    return False
            else:
                print_success("No conflict markers found - merge looks clean")
                
        except Exception as e:
            print_error(f"Git mergetool failed for {merged_file}: {e}")
            return False
    
    elif tool == "meld":
        print("🚀 Meld 3-Way Merge")
        print("=======================")
        print("Opening Meld for a 3-way merge.")
        print(f"  - LEFT: Your version (local)")
        print(f"  - MIDDLE: Common ancestor (base)")
        print(f"  - RIGHT: Patch version (remote)")
        print(f"  - OUTPUT: The final resolved file (merged)")
        print()
        
        try:
            # Meld command: meld local base remote -o output
            run_command([
                "meld", local_file, base_file, remote_file,
                "-o", merged_file,
                f"--label=LOCAL ({context['branch_name']})",
                f"--label=BASE ({context['from_ref']})",
                f"--label=REMOTE ({context['to_ref']})"
            ], capture_output=False)
        except Exception as e:
            print_error(f"Meld failed: {e}")
            return False

    elif tool == "vimdiff":
        print("🚀 Vimdiff 3-Way Merge")
        print("=======================")
        print("Opening Vimdiff with files:")
        print(f"  - LEFT: Your version (local)")
        print(f"  - MIDDLE: The file to resolve (merged)")
        print(f"  - RIGHT: Patch version (remote)")
        print()
        print("💡 In vimdiff, edit the middle file (MERGED).")
        print("   Use `:diffget` and `:diffput` with buffer numbers (e.g., `:diffget 1`) to pull changes.")
        print("   When done, save and exit all files with `:wqa`.")
        print()
        input("Press Enter to open vimdiff...")

        try:
            # We will show LOCAL, the conflicted file to edit, and REMOTE content.
            run_command([
                "vimdiff",
                local_file,
                merged_file,
                remote_file
            ], capture_output=False)
        except Exception as e:
            print_error(f"Vimdiff failed: {e}")
            print_warning("Falling back to classic vim.")
            try:
                run_command(['vim', merged_file], capture_output=False)
            except Exception as e2:
                print_error(f"Classic vim also failed: {e2}")
                return False
    
    else:
        print_error(f"Unknown diff tool: {tool}")
        return False
    
    print_success(f"Finished editing {merged_file}")
    return True

def handle_conflicts(context):
    """Enhanced conflict handling function"""
    print()
    print_header("🔥 CONFLICT RESOLUTION REQUIRED")
    print(f"Repository path: {context['repo_path']}")
    print(f"Repository type: {context['repo_type']}")
    print(f"Branch: {context['branch_name']}")
    print(f"Base commit: {context['base_commit']}")
    print()
    print("🎯 PATCH CONTEXT:")
    print(f"  📥 SOURCE (what we're bringing in): {context['to_full_ref']}")
    print(f"  📍 TARGET (where we're applying): {context['branch_name']} (based on {context['base_commit']})")
    print(f"  🔄 MERGE DIRECTION: {context['to_full_ref']} → {context['branch_name']}")
    print()
    
    # Show conflicted files with more context
    conflicted_files = get_conflicted_files(context['repo_path'])
    if conflicted_files:
        print("📋 Files with conflicts:")
        for file in conflicted_files:
            file_path = Path(context['repo_path']) / file
            if file_path.exists():
                conflict_count = count_conflict_markers(file_path)
                print(f"  📝 {file} ({conflict_count} conflict sections)")
                
                # Show brief context about what changed
                print("     🔍 Conflict preview:")
                preview_lines = show_conflict_preview(file_path)
                for line in preview_lines:
                    print(f"       {line}")
                print()
    
    # Detect available diff tools
    available_tools = detect_diff_tools()
    print(f"🔧 Available diff tools: {', '.join(available_tools)}")
    print()
    
    print("📖 Conflict Resolution Guide:")
    print("==============================")
    print("In conflict markers, you'll see:")
    print("  <<<<<<< HEAD")
    print(f"  (current branch content - YOUR version in {context['branch_name']})")
    print("  =======")
    print(f"  (incoming patch content - from {context['to_full_ref']})")
    print("  >>>>>>> [commit hash]")
    print()
    print("🎯 DECISION GUIDE:")
    print(f"  • Keep UPPER section = Keep current {context['branch_name']} version")
    print(f"  • Keep LOWER section = Accept patch from {context['to_full_ref']}")
    print("  • Combine both = Merge both changes manually")
    print()
    
    print("🛠️  Resolution options:")
    print("1. Use diff tool with enhanced context (RECOMMENDED)")
    print("2. Show detailed file comparison first")
    print("3. Edit with nano (simple, safe)")
    print("4. Edit with vim (shows conflict markers)")
    print("5. Show detailed conflict analysis")
    print("6. Stage files (if already resolved)")
    print("7. Abort")
    print()
    
    choice = input("Choose option (1-7): ").strip()
    
    if choice == "1":
        if not available_tools:
            print("No diff tools available. Using nano instead.")
            choice = "3"
        else:
            # Choose diff tool
            if len(available_tools) == 1:
                chosen_tool = available_tools[0]
                print(f"Using {chosen_tool}")
            else:
                print("Choose diff tool:")
                for i, tool in enumerate(available_tools, 1):
                    print(f"{i}. {tool}")
                print()
                
                try:
                    tool_choice = int(input(f"Choose tool (1-{len(available_tools)}): ").strip())
                    if 1 <= tool_choice <= len(available_tools):
                        chosen_tool = available_tools[tool_choice - 1]
                    else:
                        print("Invalid choice, using first available tool")
                        chosen_tool = available_tools[0]
                except ValueError:
                    print("Invalid choice, using first available tool")
                    chosen_tool = available_tools[0]
            
            print()
            print(f"🚀 ENHANCED CONFLICT RESOLUTION with {chosen_tool}")
            print("=" * 50)
            
            # Process each conflicted file with enhanced context
            for file in conflicted_files:
                file_path = Path(context['repo_path']) / file
                if not file_path.exists():
                    continue
                
                print()
                print(f"🔧 Processing: {file}")
                print("─" * 40)
                
                # Create temporary files with descriptive names for 3-way merge
                with tempfile.TemporaryDirectory() as temp_dir:
                    temp_path = Path(temp_dir)
                    
                    # Define file paths for 3-way merge
                    local_file = temp_path / f"LOCAL_{context['branch_name']}_{Path(file).name}"
                    remote_file = temp_path / f"REMOTE_from_{context['to_ref'].replace('/', '_')}_{Path(file).name}"
                    base_file = temp_path / f"BASE_from_{context['from_ref'].replace('/', '_')}_{Path(file).name}"
                    
                    # Extract LOCAL (ours) version from the branch we're on
                    try:
                        result = run_command(f"git show {context['base_commit']}:{file}", cwd=context['repo_path'])
                        local_file.write_text(result.stdout, encoding='utf-8')
                        print(f"📄 LOCAL (ours, on branch {context['branch_name']}): {local_file.name}")
                    except:
                        print(f"📄 LOCAL (ours): (file did not exist at {context['base_commit']})")
                        local_file.write_text("", encoding='utf-8')

                    # Extract REMOTE (theirs) version from the patch's target
                    try:
                        result = run_command(f"git show {context['to_full_ref']}:{file}", cwd=context['repo_path'])
                        remote_file.write_text(result.stdout, encoding='utf-8')
                        print(f"📄 REMOTE (theirs, from patch {context['to_ref']}): {remote_file.name}")
                    except:
                        print(f"📄 REMOTE (theirs): (file did not exist at {context['to_full_ref']})")
                        remote_file.write_text("", encoding='utf-8')

                    # Extract BASE (common ancestor) version from the patch's source
                    try:
                        result = run_command(f"git show {context['from_full_ref']}:{file}", cwd=context['repo_path'])
                        base_file.write_text(result.stdout, encoding='utf-8')
                        print(f"📄 BASE (ancestor, from {context['from_ref']}): {base_file.name}")
                    except:
                        print(f"📄 BASE (ancestor): (file did not exist at {context['from_full_ref']})")
                        base_file.write_text("", encoding='utf-8')

                    print(f"📄 MERGED (result, edit this file): {file_path.name}")
                    print()
                    
                    print("🎯 FILE CONTEXT:")
                    print(f"  • You're merging FROM: {context['to_full_ref']}")
                    print(f"  • Into branch: {context['branch_name']}")
                    print(f"  • Based on: {context['base_commit']}")
                    print()
                    
                    input(f"🚀 Ready to resolve {file}? Press Enter to continue...")
                    
                    if use_diff_tool_enhanced(chosen_tool, str(file_path), str(local_file), 
                                            str(remote_file), str(base_file), context):
                        print_success(f"Processed {file}")
                        
                        # Verify resolution
                        if count_conflict_markers(file_path) > 0:
                            print_warning(f"Conflict markers still found in {file}")
                            continue_anyway = input("Continue anyway? (y/N): ").strip().lower()
                            if continue_anyway != 'y':
                                print(f"Skipping {file} - please resolve manually")
                                continue
                        else:
                            print_success("No conflict markers found - merge looks clean")
                            
                            # Show final result preview
                            print()
                            print("📋 FINAL RESULT preview:")
                            print("─" * 25)
                            try:
                                lines = file_path.read_text(encoding='utf-8').split('\n')[:10]
                                for line in lines:
                                    print(f"  {line}")
                                print("  ... (showing first 10 lines)")
                            except:
                                print("  (unable to preview)")
                            print()
                    else:
                        print_error(f"Failed to process {file} with {chosen_tool}")
                        print("You can continue with other files or try manual editing")
            
            print()
            print("🎉 CONFLICT RESOLUTION COMPLETE")
            print("=" * 32)
            stage_choice = input("Stage all resolved files? (Y/n): ").strip().lower()
            if stage_choice != 'n':
                run_command("git add .", cwd=context['repo_path'])
                print_success("All changes staged.")
                print()
                print("📊 Final status:")
                result = run_command("git status --short", cwd=context['repo_path'])
                print(result.stdout)
            return True
    
    elif choice == "2":
        # Show detailed file comparison
        print()
        print("📊 DETAILED FILE COMPARISON")
        print("═" * 27)
        for file in conflicted_files:
            file_path = Path(context['repo_path']) / file
            if no_path.exists():
                continue
            
            print()
            print(f"📁 FILE: {file}")
            print("─" * 40)
            
            # Show what's in each version
            print(f"🔵 CURRENT VERSION ({context['branch_name']}):")
            try:
                result = run_command(f"git show HEAD:{file}", cwd=context['repo_path'])
                lines = result.stdout.split('\n')[:15]
                for line in lines:
                    print(f"   │ {line}")
            except:
                print("   │ (file not in current branch)")
            print()
            
            print(f"🟢 PATCH VERSION ({context['to_ref']}):")
            try:
                result = run_command(f"git show {context['to_full_ref']}:{file}", 
                                   cwd=context['repo_path'])
                lines = result.stdout.split('\n')[:15]
                for line in lines:
                    print(f"   │ {line}")
            except:
                print("   âot in patch source)")
            print()
            
            print("🔴 CONFLICTED VERSION (what you see now):")
            try:
                lines = file_path.read_text(encoding='utf-8').split('\n')[:15]
                for line in lines:
                    print(f"   │ {line}")
            except:
                print("   │ (unable to read)")
            print()
            
            print("🔍 CONFLICT LOCATIONS:")
            try:
                with open(file_path, 'r', encoding='utf-8')  as f:
                    for i, line in enumerate(f, 1):
                        if re.match(r'^(<<<<<<<|=======|>>>>>>>)', line):
                            print(f"   → Line {i}: {line.strip()}")
            except:
                print("   → No conflict markers found")
            print()
        
        input("Return to main menu? Press Enter...")
        return handle_conflicts(context)
    
    elif choice in ["3", "4"]:
        editor = "nano" if choice == "3" else "vim"
        print(f"Openfiles with {editor}...")
        for file in conflicted_files:
            file_path = Path(context['repo_path']) / file
            if file_path.exists():
                print()
                print(f"Editing: {file}")
                if editor == "nano":
                    print("Look for <<<<<<< ======= >>>>>>> markers")
                else:
                    print("In vim: Search for <<<<<<< with /<<<<<<< then resolve conflicts")
                input(f"Press Enter to open in {editor}...")
                run_command([editor, str(file_path)], capture_output=False)
        
        print()
        stage_choice = input("Stage all resolved files? (Y/n): ").strip().lower()
        if stage_choice != 'n':
            run_command("git add .", cwd=context['repo_path'])
            print_success("All changes staged.")
        return True
    
    elif choice == "5":
        # Show detailed conflict analysis
        print()
        print("📋 Detailed conflict analysis:")
        print("=" * 30)
        for file in conflicted_files:
            file_path = Path(context['repo_path']) / file
            if file_path.exists():
                print()
                print(f"📝 {file}:")
                print("-" * 50)
                try:
                    with open(file_path, 'r', encoding='utf-8') as f:
                        lines = f.readlines()
                    
                    for i, line in enumerate(lines, 1):
                        if re.match(r'^(<<<<<<<|=======|>>>>>>>)', line):
                          # Show context around conflict markers
                            start = max(0, i-3)
                            end = min(len(lines), i+2)
                            for j in range(start, end):
                                marker = ">>> " if j == i-1 else "    "
                                print(f"{marker}{j+1:4}: {lines[j].rstrip()}")
                            print()
                except:
                    print("No conflict markers found or unable to read file")
                print()
        
        input("Press Enter to return to menu...")
        return handle_conflicts(context)
    
    elif choice == "6":
        print("Staging all files as-is...")
        run_command("git add .", cwd=context['repo_path'])
        print_success("All files staged.")
        return True
    
    elif choice == "7":
        print("🚫 Aborting patch application...")
        run_command("git reset --hard HEAD", cwd=context['repo_path'])
        sys.exit(1)
    
    else:
        print_err("Invalid option. Please choose 1-7.")
        return handle_conflicts(context)

def main():
    parser = argparse.ArgumentParser(
        description="Enhanced patch and apply workflow with better conflict resolution",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # With explicit base_commit and repo_type
  python3 prepare_repo.py gs-changes goldmansachs/v0.49.0 v0.49.0 --base_commit v0.49.0 --repo_type common
  python3 prepare_repo.py my-branch goldmansachs/v2.51.2 abc123 --base_commit v2.51.0 --repo_type prometheus

  # Auto-detecting repo_type, and auto-detecting base_commit from tag
  python3 prepare_repo.py thanos-fix goldmansachs/v0.34.1 v0.34.0
  
  # Specifying repo_type, but auto-detecting base_commit
  python3 prepare_repo.py alert-fix goldmansachs/v0.26.1 v0.26.0 --repo_type alertmanager

Environment variables:
  EDITOR       : Editor to use (default: nano)
        """
    )
    
    parser.add_argument("branch_name", help="Name for the new branch")
    parser.add_argument("from_ref", help="Source reference for patch generation")
    parser.add_argument("to_ref", help="Target reference for patch generation")
    parser.add_argument("--base_commit", default=None, 
                       help="Commit hash or tag to base the new branch on (optional). If not provided, uses tag with same name as branch_name from upstream.")
    parser.add_argument("--repo_type", default="auto", 
                       help="Repository type (optional, auto-detects if not provided)")
    
    if len(sys.argv) < 4:
        parser.print_help()
        print()
        show_repo_types()
        sys.exit(1)
    
    args = parser.parse_args()
    
    # Auto-detect repository type if not provided or set to "auto"
    if args.repo_type == "auto":
        args.repo_type = detect_repo_type()
        print(f"🔍 Auto-detected repository type: {args.repo_type}")
    
    # Get repository URLs based on type
    repo_urls = get_repo_urls(args.repo_type)
    
    print()
    print("📋 Repository Configuration:")
    print(f"   Type: {args.repo_type}")
    print(f"   Upstream: {repo_urls['upstream']}")
    print(f"   Goldman Sachs: {repo_urls['gs']}")
    print()
    
    print_header("PATCH AND APPLY WORKFLOW")
    print(f"Repository type: {args.repo_type}")
    print(f"Branch name: {args.branch_name}")
    print(f"Base commit: {args.base_commit or 'auto'}")
    print(f"Patch from: {args.from_ref}")
    print(f"Patch to: {args.to_ref}")
    print(f"Editor: {os.environ.get('EDITOR', 'nano')}")
    
    # Configuration
    work_dir = f"temp_patch_work_{args.repo_type}_{int(datetime.now().timestamp())}"
    
    # Get file filters
    filters = FILE_FILTERS.get(args.repo_type, FILE_FILTERS["common"])
    print()
    print(f"📁 File filters for {args.repo_type}:")
    print(f"   Include: {filters['include']}")
    print(f"   Exclude: {filters['exclude']}")
    
    try:
        print_step(1, "Creating working directory and cloning repository...")
        os.makedirs(work_dir, exist_ok=True)
        work_path = Path(work_dir).resolve()
        print(f"Working in: {work_path}")
        
        # Clone Goldman Sachs repository
        print(f"Cloning {repo_urls['gs']}...")
        run_command(f"git clone {repo_urls['gs']} cloned_repo", cwd=work_path)
        repo_path = work_path / "cloned_repo"
        
        # Add upstream as remote for patch generation
        print("Adding upstream remote...")
        run_command(f"git remote add upstream {repo_urls['upstream']}", cwd=repo_path)
        run_command("git fetch upstream", cwd=repo_path)
        run_command("git fetch --tags upstream", cwd=repo_path)
        run_command("git fetch origin", cwd=repo_path)
        run_command("git fetch --tags origin", cwd=repo_path)
        
        # Set up better merge configuration
        setup_git_merge_config(repo_path)
        
        base_commit = args.base_commit
        if not base_commit:
            print_step("1.5", f"Auto-detecting base commit from tag '{args.branch_name}'...")
            try:
                # Check if tag exists locally. We've already fetched tags from upstream.
                run_command(f"git show-ref --verify --quiet refs/tags/{args.branch_name}", cwd=repo_path)
                base_commit = args.branch_name
                print_success(f"Using tag '{base_commit}' as base commit.")
            except Exception:
                print_error(f"Tag '{args.branch_name}' not found in remotes.")
                print_error("If `base_commit` is not provided, a tag with the same name as `branch_name` must exist.")
                sys.exit(1)
        
        print_step(2, f"Creating new branch '{args.branch_name}' based on '{base_commit}'...")
        run_command(f"git checkout -b {args.branch_name} {base_commit}", cwd=repo_path)
        print_success(f"Branch '{args.branch_name}' created and checked out")
        
        print_step(3, f"Generating patch from {args.from_ref} to {args.to_ref}...")
        
        # Resolve references
        from_full_ref = resolve_reference(args.from_ref, repo_path)
        to_full_ref = resolve_reference(args.to_ref, repo_path)
        
        print()
        print("🔧 Debug information:")
        print(f"   FROM_REF: '{args.from_ref}'")
        print(f"   TO_REF: '{args.to_ref}'")
        print(f"   FROM_FULL_REF: '{from_full_ref}'")
        print(f"   TO_FULL_REF: '{to_full_ref}'")
        print()
        
        print("Resolved references:")
        print(f"  FROM: {args.from_ref} -> {from_full_ref}")
        print(f"  TO: {args.to_ref} -> {to_full_ref}")
        
        # Verify references exist
        print("Verifying references exist...")
        try:
            run_command(f"git rev-parse --verify {from_full_ref}", cwd=repo_path)
        except:
            print_error(f"Cannot find reference '{from_full_ref}'")
            sys.exit(1)
        
        try:
            run_command(f"git rev-parse --verify {to_full_ref}", cwd=repo_path)
        except:
            print_error(f"Cannot find reference '{to_full_ref}'")
            sys.exit(1)
        
        print_success("Both references verified")
        
        # Show what commits we're comparing
        print()
        print("📊 Comparison details:")
        from_commit = run_command(f"git rev-parse --short {from_full_ref}", cwd=repo_path).stdout.strip()
        to_commit = run_command(f"git rev-parse --short {to_full_ref}", cwd=repo_path).stdout.strip()
        print(f"FROM commit: {from_commit} ({from_full_ref})")
        print(f"TO commit:   {to_commit} ({to_full_ref})")
        
        # Check if they're the same commit
        from_full_commit = run_command(f"git rev-parse {from_full_ref}", cwd=repo_path).stdout.strip()
        to_full_commit = run_command(f"git rev-parse {to_full_ref}", cwd=repo_path).stdout.strip()
        
        if from_full_commit == to_full_commit:
            print()
            print_warning("Both references point to the same commit!")
            print(f"   FROM: {from_full_ref} -> {from_full_commit}")
            print(f"   TO:   {to_full_ref} -> {to_full_commit}")
            print()
            print("This means there are no differences to patch.")
            print("Please check if you're using the correct references.")
            sys.exit(1)
        
        # Get list of all changed files
        print()
        print("Getting all changed files...")
        diff_range = f"{from_full_ref}...{to_full_ref}"
        print(f"🔧 Debug: Diff range: '{diff_range}'")
        
        result = run_command(f"git diff {diff_range} --name-only", cwd=repo_path)
        all_changed_files = [f.strip() for f in result.stdout.split('\n') if f.strip()]
        
        if not all_changed_files:
            print("No changes found between references.")
            sys.exit(1)
        
        print(f"All changed files ({len(all_changed_files)} total):")
        for file in all_changed_files:
            print(f"  {file}")
        print()
        
        # Apply filters
        print(f"Applying filters for repository type: {args.repo_type}")
        print(f"Include pattern: {filters['include']}")
        print(f"Exclude pattern: {filters['exclude']}")
        
        # Filter files
        include_pattern = re.compile(filters['include'])
        exclude_pattern = re.compile(filters['exclude'])
        
        changed_files = []
        for file in all_changed_files:
            if not exclude_pattern.search(file) and include_pattern.search(file):
                changed_files.append(file)
        
        print()
        if not changed_files:
            print_warning("No files matching criteria found for patch generation.")
            print()
            print("Files that would be included by extension filter:")
            for file in all_changed_files:
                if include_pattern.search(file):
                    print(f"  {file}")
            print()
            print("Files excluded by exclude filter:")
            for file in all_changed_files:
                if exclude_pattern.search(file):
                    print(f"  {file}")
            print()
            
            response = input("No filtered files found. Use all changed files? (y/N): ").strip().lower()
            if response == 'y':
                changed_files = all_changed_files
            else:
                print("Exiting. You can modify the filters in the script if needed.")
                sys.exit(1)
        else:
            print(f"Filtered files to be patched ({len(changed_files)} files):")
            for file in changed_files:
                print(f"  {file}")
        
        # Generate the patch file
        patch_file = f"{args.repo_type}_{args.branch_name}.patch"
        print()
        print(f"Creating patch file: {patch_file}")
        
        if changed_files:
            # Create patch with specific files
            cmd = f"git diff {diff_range} --no-color {' '.join(changed_files)}"
            result = run_command(cmd, cwd=repo_path)
        else:
            # Create patch with all files
            result = run_command(f"git diff {diff_range} --no-color", cwd=repo_path)
        
        with open(work_path / patch_file, 'w') as f:
            f.write(result.stdout)
        
        # Generate patch summary
        print("Creating patch summary...")
        summary_content = f"""PATCH GENERATION SUMMARY
========================
Repository type: {args.repo_type}
Upstream: {repo_urls['upstream']}
Goldman Sachs: {repo_urls['gs']}
Branch: {args.branch_name}
Base commit: {base_commit}
Patch from: {from_full_ref} ({from_commit})
Patch to: {to_full_ref} ({to_commit})
Generated: {datetime.now()}
Working directory: {repo_path}

TOTAL FILES CHANGED: {len(all_changed_files)}
FILTERED FILES: {len(changed_files)}

FILTERED FILES INCLUDED:
{chr(10).join(changed_files)}

FILES EXCLUDED BY FILTERS:
{chr(10).join([f for f in all_changed_files if f not in changed_files])}

DIFF STATISTICS (filtered files):
"""
        
        # Add diff stats
        if changed_files:
            result = run_command(f"git diff {diff_range} --stat {' '.join(changed_files)}", cwd=repo_path)
        else:
            result = run_command(f"git diff {diff_range} --stat", cwd=repo_path)
        summary_content += result.stdout
        
        with open(work_path / "patch_summary.txt", 'w') as f:
            f.write(summary_content)
        
        print_step(4, f"Applying patch to branch '{args.branch_name}'...")
        
        # Check if patch file has content
        patch_path = work_path / patch_file
        if patch_path.stat().st_size == 0:
            print_warning("Patch file is empty. No changes to apply.")
            print("This might mean the references point to the same commit or no files match the filters.")
            sys.exit(0)
        
        print(f"📊 Patch file size: {patch_path.stat().st_size} bytes")
        
        # Apply the patch with conflict handling
        print("Applying patch...")
        patch_success = False
        
        try:
            # Try normal patch application first
            run_command(f"git apply --verbose {patch_path}", cwd=repo_path)
            print_success("Patch applied successfully")
            patch_success = True
        except:
            print_error("Normal patch application failed")
            print("Attempting 3-way merge...")
            
            try:
                run_command(f"git apply --3way {patch_path}", cwd=repo_path)
                print_success("Patch applied with 3-way merge")
                patch_success = True
            except:
                print_error("3-way merge failed - conflicts detected")
                
                # Force apply with 3-way to create conflict markers
                try:
                    run_command(f"git apply --3way {patch_path}", cwd=repo_path, check=False)
                except:
                    pass
                
                # Create context for conflict handling
                context = {
                    'repo_path': str(repo_path),
                    'repo_type': args.repo_type,
                    'branch_name': args.branch_name,
                    'base_commit': base_commit,
                    'from_ref': args.from_ref,
                    'to_ref': args.to_ref,
                    'from_full_ref': from_full_ref,
                    'to_full_ref': to_full_ref
                }
                
                # Handle conflicts
                if handle_conflicts(context):
                    patch_success = True
        
        if not patch_success:
            print_error("Patch application completely failed")
            sys.exit(1)
        
        # Show final status
        print_step(5, "Final status...")
        result = run_command("git status --short", cwd=repo_path)
        print(result.stdout)
        
        # Check if there are any changes
        try:
            run_command("git diff --quiet", cwd=repo_path)
            print_warning("No changes detected after patch application.")
            print("This might mean the patch was already applied or the references are identical.")
        except:
            print()
            print("Files modified:")
            result = run_command("git diff --name-only", cwd=repo_path)
            print(result.stdout)
            
            print()
            print("Diff summary:")
            result = run_command("git diff --stat", cwd=repo_path)
            print(result.stdout)
            
            # Commit the changes
            print()
            commit_choice = input("Do you want to commit these changes? (y/N): ").strip().lower()
            if commit_choice == 'y':
                commit_msg = f"""Apply {args.repo_type} patch from {args.from_ref} to {args.to_ref}

Repository: {args.repo_type}
Generated patch includes changes to:
{chr(10).join([f'- {f}' for f in changed_files])}

Source: {from_full_ref}...{to_full_ref}
From commit: {from_commit}
To commit: {to_commit}"""
                
                run_command("git add .", cwd=repo_path)
                run_command(f'git commit -m "{commit_msg}"', cwd=repo_path)
                print_success("Changes committed")
                
                print()
                print(f"Branch '{args.branch_name}' is ready. You can push it with:")
                print(f"  git push origin {args.branch_name}")
            else:
                print("Changes not committed. You can commit manually with:")
                print("  git add .")
                print('  git commit -m "Applied patch"')
        
        print()
        print_header("✅ WORKFLOW COMPLETED")
        print(f"Repository type: {args.repo_type}")
        print(f"Working directory: {repo_path}")
        print(f"Branch: {args.branch_name}")
        print(f"Pah file: {work_path / patch_file}")
        print(f"Summary: {work_path / 'patch_summary.txt'}")
        print()
        print("To continue working:")
        print(f"  cd {repo_path}")
        print("  git log --oneline -5")
        print()
        print("To clean up:")
        print(f"  cd {work_path.parent}")
        print(f"  rm -rf {work_dir}")
        
    except KeyboardInterrupt:
        print("\n\nScript interrupted by user")
        sys.exit(1)
    except Exception as e:
        print_error(f"Script failed: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
