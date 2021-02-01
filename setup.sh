#!/usr/local/bin/zsh

set -eux

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

## iTerm2 Shell Integration
curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | /usr/local/bin/zsh
