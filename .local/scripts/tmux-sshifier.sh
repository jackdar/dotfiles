#!/bin/bash

export FZF_DEFAULT_OPTS='
--height=20%
--tmux
--prompt="SSH > "
--print-query
--preview="awk -v HOST={} -f ~/.local/scripts/host2conf.sh ~/.ssh/config"'

# Capture both the query and the selection separately
read -r typed_host selected_host < <(grep '^[[:space:]]*Host[[:space:]]' ~/.ssh/config | cut -d ' ' -f 2 | fzf)

# Determine the final host (either selected or typed)
host=${selected_host:-$typed_host}

# Run SSH if there's a valid input
[ -n "$host" ] && tmux new-window -n [ssh]-"$host" ssh "$host"
