DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

ZSH_THEME="robbyrussell"

export ZSH="$HOME/.oh-my-zsh"

zstyle ':omz:update' mode disabled

ZSH_CUSTOM="$HOME/.zsh_custom"

plugins=(git zoxide zsh-autosuggestions zsh-syntax-highlighting)

source "$ZSH/oh-my-zsh.sh"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export MANPAGER='nvim +Man!'

if [ -d "$HOME/.local/share/fnm" ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
	source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
