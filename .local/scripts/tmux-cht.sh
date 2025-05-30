#!/bin/bash

# TMUX Cheat Sheet. Usage: "<ctrl-s> i"

selected=$(cat ~/.config/tmux/tmux-cht-languages ~/.config/tmux/tmux-cht-commands | fzf)

if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" ~/.config/tmux/tmux-cht-languages; then
    query=$(echo $query | tr ' ' '+')
    tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi
