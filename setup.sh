#!/usr/local/bin/zsh

set -eux

## Make Workspaces
mkdir Workspaces

## Don't create .DS_Store on Network Drive
defaults write com.apple.desktopservices DSDontWriteNetworkStores True
killall Finder

## Recent Applications in Dock
defaults write com.apple.dock persistent-others -array-add '{ "tile-data" = { "list-type" = 1; }; "tile-type" = "recents-tile"; }'
killall Dock

## neovim
pip3 install neovim

## nodebrew
/usr/local/opt/nodebrew/bin/nodebrew setup_dirs
nodebrew install-binary stable
nodebrew use stable

## iTerm2 Shell Integration
curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | /usr/local/bin/zsh
