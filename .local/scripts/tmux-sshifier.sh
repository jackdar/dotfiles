#!/bin/bash

# TMUX SSHifier. Usage: "<ctrl-s> f"

export FZF_DEFAULT_OPTS='
--tmux
--prompt="SSH > "
--print-query'

# Get the fzf result with both query and selection
result=$(grep '^[[:space:]]*Host[[:space:]]' ~/.ssh/config | cut -d ' ' -f 2 | fzf)

# Split the result into lines
IFS=$'\n' read -rd '' -a lines <<<"$result"

# First line is always the query
typed_host="${lines[0]}"

# Second line is the selection (if any)
if [ ${#lines[@]} -gt 1 ]; then
    selected_host="${lines[1]}"
else
    selected_host=""
fi

# Use selected host if available, otherwise use typed host
host=${selected_host:-$typed_host}

# Run SSH if there's a valid input
[ -n "$host" ] && tmux neww -n [ssh]-"$host" ssh "$host"
