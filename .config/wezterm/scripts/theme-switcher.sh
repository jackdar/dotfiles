#!/bin/bash

/opt/homebrew/bin/tmux popup -E \
  "cat ~/.config/wezterm/data/colors.txt \
  | fzf --color=bg+:-1 --reverse  --preview-window=down,1 \
  --preview='source ~/.config/wezterm/scripts/theme-switcher.sh && write_colorscheme {}'"

function write_colorscheme() {
  value="$1"
  echo $value

  gawk -i inplace -v new_scheme="$value" '/^colorscheme = / { $0 = "colorscheme = \"" new_scheme "\"" } { print }' ~/.config/wezterm/globals.toml
}
