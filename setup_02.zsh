#!/usr/bin/env zsh

set -uo pipefail
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
  CHIPSET="Silicon"
elif [[ $PROCESSOR_ARCH == "i386" ]]; then
  CHIPSET="Intel"
fi

# ---- script logic here ----
msg "${RED}Start setup_02 for ${CHIPSET}(${PROCESSOR_ARCH}).${NOFORMAT}"

## Install Rust
msg "${BLUE}Install Rust.${NOFORMAT}"
brew install openssl
curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
cargo install cargo-update

## Install packages via Homebrew
msg "${BLUE}Bundle brew packages.${NOFORMAT}"
brew bundle --file $HOME/.zprezto/Brewfile

## Install fzf key bindings and fuzzy completion
$(brew --prefix)/opt/fzf/install

## for AstroNvim
msg "${BLUE}Start setting up AstroNvim.${NOFORMAT}"
pip3 install neovim
git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
rm -rf ~/.config/nvim/.git
nvim --headless -c 'quitall'

## for Volta
msg "${BLUE}Start setting up Volta.${NOFORMAT}"
if which volta >/dev/null; then
  volta install node

  ## Install Global Packages
  npm install --global commitizen
  npm install --global cz-emoji
  npm install --global npm-check-updates
fi

## iTerm2 Shell Integration
msg "${BLUE}Install iTerm2 Shell Integration.${NOFORMAT}"
curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | $(brew --prefix)/bin/zsh

## Don't create .DS_Store on Network Drive
msg "${BLUE}Don't create .DS_Store on Network Drive${NOFORMAT}"
defaults write com.apple.desktopservices DSDontWriteNetworkStores True
killall Finder

## Search own public key
msg "${BLUE}Start setting up GPG Key.${NOFORMAT}"
gpg --keyserver hkps://keys.openpgp.org --search-keys shin@sforzando.co.jp
msg "${ORANGE}You have to trust the key: ${CYAN}gpg --edit-key KEYID, trust${NOFORMAT}"

## Set Default Shell
msg "${BLUE}Start setting up default shell.${NOFORMAT}"
if ! grep -q $(brew --prefix)/bin/zsh /etc/shells; then
  echo $(brew --prefix)/bin/zsh | sudo tee -a /etc/shells
fi
msg "${ORANGE}You have to change default shell: ${CYAN}chsh -s \$(brew --prefix)/bin/zsh${NOFORMAT}"

msg "${RED}setup_02 is complete.${NOFORMAT}"
