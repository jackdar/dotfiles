#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

stow . -d "$DOTFILES_DIR" -t ~

if [[ $OSTYPE == "darwin"* ]]; then
  stow darwin -d "$DOTFILES_DIR" -t ~
fi
