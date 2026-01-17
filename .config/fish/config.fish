set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_DATA_HOME $HOME/.local/share

set -gx EDITOR nvim
set -gx PROJECTS ~/projects

set -gx AWS_DEFAULT_PROFILE staging
set -gx AWS_DEFAULT_REGION ap-southeast-2

set -gx GIT_CONFIG_GLOBAL $XDG_CONFIG_HOME/git/config

fish_add_path -p ~/.cargo/bin
fish_add_path -p ~/go/bin
fish_add_path -p ~/.local/bin
fish_add_path -p ~/.local/scripts

if status is-interactive
    fish_vi_key_bindings

    # Cache fnm initialization for faster startup
    set -l fnm_cache $XDG_CACHE_HOME/fnm_init.fish
    set -l fnm_bin (which fnm 2>/dev/null)

    # Regenerate cache if fnm binary is newer than cache or cache doesn't exist
    if test -n "$fnm_bin"
        if not test -f $fnm_cache; or test $fnm_bin -nt $fnm_cache
            fnm env --use-on-cd --shell fish >$fnm_cache
        end
    end

    # Source the cached initialization
    if test -f $fnm_cache
        source $fnm_cache
    end

    alias cd='z'
    # alias c='clear'

    alias ls='ls --color=auto'
    alias la='ls -a --color=auto'
    alias ll='ls -lh --color=auto'
    alias zm='open https://us06web.zoom.us/j/86568961355?pwd=3UekhPON71z5isaaCloXblz7o1GS9b.1'
    alias vim='nvim'

    abbr --add --function __tmux_t_command t

    set -g fish_greeting
    set -g fzf_fd_opts --hidden --max-depth 5

    set fish_cursor_default block
    set fish_cursor_insert block blink
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
