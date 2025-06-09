#!/bin/bash

# TMUX Sessionizer. Usage: "<ctrl-s> f"

if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(fd . ~/ ~/projects ~/projects/property-guide ~/projects/msp ~/projects/sykes ~/projects/cdk ~/projects/cdk/cdk-appsync ~/.config ~/personal -d 1 -t d --hidden | sed "s|$HOME|~|" | fzf | sed "s|^~|$HOME|" | sed 's:/*$::')
fi

if [[ -z $selected ]]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  tmux new-session -s $selected_name -c $selected
  exit 0
fi

if ! tmux has-session -t=$selected_name 2>/dev/null; then
  tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
