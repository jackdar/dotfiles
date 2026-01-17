#!/usr/bin/env bash

TS_PATHS=(
    "$HOME/projects"
    "$HOME/projects/property-guide"
    "$HOME/projects/msp"
    "$HOME/projects/sykes"
    "$HOME/.dotfiles"
    "$HOME/.config"
    "$HOME/github"
    "$HOME/personal"
    "$HOME/plugins"
)

# Cache configuration
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/tmux-sessionizer"
CACHE_FILE="$CACHE_DIR/directories.cache"
CACHE_MAX_AGE=300  # 5 minutes in seconds

if [[ $# -eq 1 ]]; then
    selected=$1
else
    # Get active tmux sessions
    active_sessions=""
    declare session_paths
    if tmux list-sessions &>/dev/null; then
        while IFS=: read -r session_name _; do
            # Get the session's working directory
            session_path=$(tmux display-message -p -t "$session_name" -F "#{session_path}")
            active_sessions+="[*] $session_name"$'\n'
            session_paths["$session_name"]="$session_path"
        done < <(tmux list-sessions -F "#{session_name}")
    fi

    # Check if cache is valid
    use_cache=false
    if [[ -f "$CACHE_FILE" ]]; then
        cache_age=$(($(date +%s) - $(stat -f %m "$CACHE_FILE" 2>/dev/null || stat -c %Y "$CACHE_FILE" 2>/dev/null)))
        if [[ $cache_age -lt $CACHE_MAX_AGE ]]; then
            use_cache=true
        fi
    fi

    # Get directory results (from cache or fd)
    if [[ $use_cache == true ]]; then
        fd_results=$(cat "$CACHE_FILE")
    else
        # Build fd commands for each path with optional depth specification (in parallel)
        mkdir -p "$CACHE_DIR"
        temp_files=()

        for path_spec in "${TS_PATHS[@]}"; do
            # Split path and depth (format: path:depth)
            if [[ $path_spec =~ ^(.+):([0-9]+)$ ]]; then
                path="${BASH_REMATCH[1]}"
                depth="${BASH_REMATCH[2]}"
            else
                path="$path_spec"
                depth=1
            fi

            # Expand variables in path
            eval "path=$path"

            # Run fd in background with specified depth, following symlinks and including hidden dirs
            if [[ -d "$path" ]]; then
                temp_file=$(mktemp "$CACHE_DIR/tmp.XXXXXX")
                temp_files+=("$temp_file")
                fd . "$path" -d "$depth" -t d -H -L --threads 2 > "$temp_file" &
            fi
        done

        # Wait for all background fd processes to complete
        wait

        # Combine all results
        fd_results=""
        for temp_file in "${temp_files[@]}"; do
            fd_results+=$(cat "$temp_file")$'\n'
            rm -f "$temp_file"
        done

        # Save to cache
        echo -n "$fd_results" > "$CACHE_FILE"
    fi

    # Combine active sessions (at top) with directory results, remove duplicates
    all_results=$(echo -e "${active_sessions}${fd_results}" | sed "s|$HOME|~|" | awk '!seen[$0]++')

    # Select with fzf and clean up
    fzf_selection=$(echo "$all_results" | fzf)

    # Check if selection is an active session
    if [[ $fzf_selection =~ ^\[\*\]\ (.+)$ ]]; then
        session_name="${BASH_REMATCH[1]}"
        selected="${session_paths[$session_name]}"
    else
        selected=$(echo "$fzf_selection" | sed "s|^~|$HOME|" | sed 's:/*$::')
    fi
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
