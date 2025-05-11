#!/bin/bash

# TMUX Configurator. Usage: "<ctrl-s> o"

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$((echo "$HOME/.dotfiles" && fd . ~/.config -d 1 ) | sed "s|$HOME|~|" | fzf | sed "s|^~|$HOME|" | sed 's:/*$::')
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

tmux neww zsh -c "nvim $selected -c 'lcd $selected'"
