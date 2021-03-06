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
msg "${RED}Start setup for ${CHIPSET}(${PROCESSOR_ARCH}).${NOFORMAT}"

setopt EXTENDED_GLOB

## Create Zsh configuration symbolic links from runcoms
rm -i $HOME/.z*
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

## Create symbolic links from dot_files
for dotfile in "${ZDOTDIR:-$HOME}"/.zprezto/dot_files/^README.md(.N); do
  ln -sf "$dotfile" "${ZDOTDIR:-$HOME}/.${dotfile:t}"
done

## Create .config and symbolic links
mkdir .config && \
for dotdir in "${ZDOTDIR:-$HOME}"/.zprezto/dot_config_dir/*; do
  ln -sf "$dotdir" "${ZDOTDIR:-$HOME}/.config/${dotdir:t}"
done

## Set Default Shell
if ! grep -q ${BREW_BIN_PATH}/zsh /etc/shells; then
  echo ${BREW_BIN_PATH}/zsh | sudo tee -a /etc/shells
fi
chsh -s ${BREW_BIN_PATH}/zsh

## Apply Zsh Config
source $HOME/.zshrc

## Create Workspace
mkdir -p $HOME/Workspace

## Install Rust
curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

## Install packages via Homebrew
brew bundle --file $HOME/.zprezto/Brewfile

## Install Settings Sync to Visual Studio Code
code --install-extension shan.code-settings-sync

## For neovim
pip3 install neovim

## For nodebrew
if which nodebrew > /dev/null; then
  nodebrew setup_dirs
  if [[ $PROCESSOR_ARCH == "arm" ]]; then
   nodebrew compile stable
  elif [[ $PROCESSOR_ARCH == "i386" ]]; then
    nodebrew install-binary stable
  fi
  nodebrew use stable

  ## Install Global Packages
  npm install -g yarn
  npm install -g npm-check-updates
  npm install -g commitizen
  npm install -g cz-emoji
fi

## iTerm2 Shell Integration
curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | ${BREW_BIN_PATH}/zsh

## Don't create .DS_Store on Network Drive
defaults write com.apple.desktopservices DSDontWriteNetworkStores True
killall Finder

## Search own public key
gpg --keyserver hkps.pool.sks-keyservers.net --search-keys shin@sforzando.co.jp
msg "${ORANGE}You have to trust the key: ${CYAN}gpg --edit-key KEYID, trust${NOFORMAT}"

msg "${RED}Setup is complete.${NOFORMAT}"
