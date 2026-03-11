#!/usr/bin/env bash

sudo apt-get install fd-find

if has fdfind; then
  mkdir -p "$HOME/.local/bin"
  if [[ -L "$HOME/.local/bin/fd" || ! -e "$HOME/.local/bin/fd" ]]; then
    ln -sfn "$(command -v fdfind)" "$HOME/.local/bin/fd"
  fi
fi
