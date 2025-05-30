#!/bin/bash

if [ $# -eq 1 ]; then
    cd "$1" || exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: Not in a git repository"
    exit 1
fi

remote_url=$(git remote get-url origin 2>&1)
exit_code=$?

if [ $exit_code -ne 0 ] || [ -z "$remote_url" ]; then
    echo "Error: No origin remote found or git command failed"
    echo "Available remotes:"
    git remote -v
    exit 1
fi

if [[ $remote_url =~ ^git@([^:]+):(.+)\.git$ ]]; then
    host="${BASH_REMATCH[1]}"
    repo_path="${BASH_REMATCH[2]}"

    case "$host" in
    "github.com")
        web_url="https://github.com/$repo_path"
        ;;
    "bitbucket.org")
        web_url="https://bitbucket.org/$repo_path"
        ;;
    "gitlab.com")
        web_url="https://gitlab.com/$repo_path"
        ;;
    *)
        web_url="https://$host/$repo_path"
        ;;
    esac

    open "$web_url"

elif [[ $remote_url =~ https?:// ]]; then
    open "$remote_url"

else
    echo "Error: Unrecognized remote URL format: $remote_url"
    exit 1
fi
