DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

ZSH_THEME="robbyrussell"

export ZSH="$HOME/.oh-my-zsh"

zstyle ':omz:update' mode auto

ZSH_CUSTOM="$HOME/.config/zsh"

plugins=(
  git
  fnm
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export MANPAGER='nvim +Man!'
export GPG_TTY=$(tty)

alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vim='nvim'
alias t='tmux-sessionizer'

[ -s "/Users/jackdarlington/.bun/_bun" ] && source "/Users/jackdarlington/.bun/_bun"

eval "$(fnm env --use-on-cd --shell zsh)"

eval "$(task-cli completions zsh)"

source "$HOME/.sdkman/bin/sdkman-init.sh"

if [[ $- == *i* ]]; then
    eval "$(zoxide init zsh --cmd cd)"
fi
