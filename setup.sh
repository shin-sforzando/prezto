#!/usr/bin/env zsh

set -eux

PROCESSOR_ARCH=$(uname -p)

if [[ $PROCESSOR_ARCH == "arm" ]]; then
  CHIPSET="M1"
  elif [[ $PROCESSOR_ARCH == "i386" ]]; then
    CHIPSET="Intel"
  else
    CHIPSET="Unknown"
fi

echo "Start setup for ${CHIPSET} (${PROCESSOR_ARCH})."

## Make Workspace
mkdir -p ~/Workspace

## Don't create .DS_Store on Network Drive
defaults write com.apple.desktopservices DSDontWriteNetworkStores True
killall Finder

## Install Settings Sync to Visual Studio Code
code --install-extension shan.code-settings-sync

## neovim
pip3 install neovim

## nodebrew
/usr/local/opt/nodebrew/bin/nodebrew setup_dirs
nodebrew install-binary stable
nodebrew use stable

## Install Rust
curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -y

## iTerm2 Shell Integration
if [[ $CHIPSET == "M1" ]]; then
  echo $(which zsh)
  elif [[ $CHIPSET == "Intel" ]]; then
    curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | /usr/local/bin/zsh
  else
    echo $(which zsh)
fi
