#!/usr/bin/env zsh
# Debug script for Ghostty + Prezto prompt issue

echo "=== Prezto/Ghostty Prompt Debug Info ==="
echo ""
echo "Current directory: $PWD"
echo ""
echo "precmd_functions (in order):"
for ((i=1; i<=${#precmd_functions[@]}; i++)); do
  echo "  [$i] ${precmd_functions[$i]}"
done
echo ""
echo "chpwd_functions (in order):"
for ((i=1; i<=${#chpwd_functions[@]}; i++)); do
  echo "  [$i] ${chpwd_functions[$i]}"
done
echo ""
echo "preexec_functions (in order):"
for ((i=1; i<=${#preexec_functions[@]}; i++)); do
  echo "  [$i] ${preexec_functions[$i]}"
done
echo ""
echo "PS1 (first 200 chars): ${PS1:0:200}"
echo ""
echo "RPROMPT: $RPROMPT"
echo ""
echo "_prompt_sorin_git variable: '$_prompt_sorin_git'"
echo ""
echo "Git status:"
git rev-parse --git-dir 2>&1 || echo "Not in a git repository"
echo ""
echo "Async worker status:"
async_job -l prompt_sorin 2>&1 || echo "No async jobs or async not loaded"
