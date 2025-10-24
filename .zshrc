DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"
DISABLE_AUTO_TITLE="true"
HISTORY_IGNORE="(ls|cat|bat|AWS|SECRET)"

setopt hist_ignore_all_dups hist_ignore_space

zstyle ':omz:update' mode disabled # disable automatic updates

# Smarter completion initialization
fpath=(/Users/jackdarlington/.docker/completions $fpath)
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
  compinit
else
  compinit -C
fi

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"

ZSH_THEME="robbyrussell"
ZSH_CUSTOM=~/.zsh_custom/

# zstyle ':omz:plugins:nvm' lazy yes

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Oh My Zsh
source $ZSH/oh-my-zsh.sh

source $ZSH_CUSTOM/profile.zsh
source $ZSH_CUSTOM/aliases.zsh
source $ZSH_CUSTOM/options.zsh

[[ -f $ZSH_CUSTOM/bachcare.zsh ]] && source $ZSH_CUSTOM/bachcare.zsh
