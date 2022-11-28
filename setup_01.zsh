#!/usr/bin/env zsh

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "$0")" &>/dev/null && pwd -P)

usage() {
  cat <<EOF
Usage: $(basename "$0") [-h] [-v]

Script description here.

Available options:

-h, --help      Print this help and exit
-v, --verbose   Print script debug info
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT

  # ---- script cleanup here ----
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

parse_params() {
  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) set -x ;;
    --no-color) NO_COLOR=1 ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done
  return 0
}

parse_params "$@"
setup_colors

# ---- chipset check here ----
PROCESSOR_ARCH=$(uname -p)
if [[ $PROCESSOR_ARCH == "arm" ]]; then
  CHIPSET="M1"
  BREW_BIN_PATH="/opt/homebrew/bin"
  elif [[ $PROCESSOR_ARCH == "i386" ]]; then
    CHIPSET="Intel"
    BREW_BIN_PATH="/usr/local/bin"
fi

# ---- script logic here ----
msg "${RED}Start setup 01 for ${CHIPSET}(${PROCESSOR_ARCH}).${NOFORMAT}"

setopt EXTENDED_GLOB

## Create Zsh configuration symbolic links from runcoms
msg "${BLUE}Start setting up runcoms.${NOFORMAT}"
rm -if $HOME/.zshrc
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

## Create symbolic links from dot_files
msg "${BLUE}Start setting up dotfiles.${NOFORMAT}"
for dotfile in "${ZDOTDIR:-$HOME}"/.zprezto/dot_files/^README.md(.N); do
  ln -sf "$dotfile" "${ZDOTDIR:-$HOME}/.${dotfile:t}"
done

## Create .config and symbolic links
msg "${BLUE}Start setting up .config.${NOFORMAT}"
mkdir .config && \
for dotdir in "${ZDOTDIR:-$HOME}"/.zprezto/dot_config_dir/*; do
  ln -sf "$dotdir" "${ZDOTDIR:-$HOME}/.config/${dotdir:t}"
done

## Create Workspace
msg "${BLUE}Make ~/.Workspace.${NOFORMAT}"
mkdir -p $HOME/Workspace

## Apply Zsh Config
msg "${BLUE}Reload .zshrc.${NOFORMAT}"
source $HOME/.zshrc

msg "${RED}Setup 01 is complete.${NOFORMAT}"
