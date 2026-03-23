DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

ZSH_THEME="robbyrussell"

export ZSH="$HOME/.oh-my-zsh"

zstyle ':omz:update' mode disabled

ZSH_CUSTOM="$HOME/.config/zsh"

plugins=(
  git
  zoxide
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
