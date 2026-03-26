#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

stow . --restow -d "$DOTFILES_DIR" -t ~

if [[ $OSTYPE == "darwin"* ]]; then
  stow darwin --restow -d "$DOTFILES_DIR" -t ~
fi
