#!/bin/bash

/opt/homebrew/bin/tmux popup -E \
    "fc-list :spacing=100 family \
    | grep -v '^\\.' \
    | cut -d ',' -f1 \
    | sort -u \
    | fzf --color=bg+:-1 --reverse --preview-window=down,1 \
    --preview='source ~/.config/wezterm/scripts/font-switcher.sh && write_font {}'"

function write_font() {
    value="$1"
    echo $value

    gawk -i inplace -v new_font="$value" '/^font = / { $0 = "font = \"" new_font "\"" } { print }' ~/.config/wezterm/globals.toml
}
