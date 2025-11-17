#!/usr/bin/env zsh

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Library
export LIB="$HOME/Library/"
export LIB_APP_SUPPORT="$HOME/Library/Application Support/"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Other
export VIMCONFIG="$XDG_DATA_HOME/nvim"

# History
export HISTSIZE=5000
export HISTFILE="$ZDOTDIR/.zhistory"
export SAVEHIST=$HISTSIZE
export HISTDUP=erase
export HISTORY_IGNORE="(ls|cat|bat|AWS|SECRET)"

# fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Git
export GIT_CONFIG_GLOBAL=$HOME/.config/git/.gitconfig
export GIT_IGNORE_GLOBAL=$HOME/.config/git/.ignore

# Golang
export GO_PATH="$HOME/go"
export GO_BIN="$GO_PATH/bin"

# Path
export PATH="$PATH:$GO_BIN"
export PATH="$FNM_PATH:$PATH"
export PATH="$XDG_DATA_HOME/composer:$PATH"
export PATH="$LIB_APP_SUPPORT/fnm:$PATH"
export PATH="$LIB/pnpm:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
