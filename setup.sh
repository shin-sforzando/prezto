#!/usr/local/bin/zsh

set -eux

## nodebrew
/usr/local/opt/nodebrew/bin/nodebrew setup_dirs
nodebrew install-binary stable
nodebrew use stable

## iTerm2 Shell Integration
curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | /usr/local/bin/zsh
