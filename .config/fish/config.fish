set -x XDG_CONFIG_HOME $HOME/.config

set -x EDITOR nvim
set -x PROJECTS ~/projects

set -x AWS_DEFAULT_PROFILE staging
set -x AWS_PROFILE staging
set -x AWS_DEFAULT_REGION ap-southeast-2
set -x AWS_REGION ap-southeast-2

set -x GIT_CONFIG_GLOBAL $XDG_CONFIG_HOME/git/config

fish_add_path -p ~/.cargo/bin
fish_add_path -p ~/go/bin
fish_add_path -p ~/.local/bin
fish_add_path -p ~/.local/scripts

if status is-interactive
    fnm env --use-on-cd --shell fish | source

    alias cd='z'

    alias ls='ls --color=auto'
    alias la='ls -a --color=auto'
    alias ll='ls -lh --color=auto'

    set -gx TS_MAX_DEPTH 1

    set -gx fish_greeting
    set -gx tide_git_truncate_length 40
    set -gx fzf_fd_opts --hidden --max-depth 5
end
