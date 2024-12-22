# Set default editor to Neovim
export EDITOR='nvim'

# Set up the Homebrew environment
eval "$(/opt/homebrew/bin/brew shellenv)"

# Starship
eval "$(starship init zsh)"

# fzf
source <(fzf --zsh)

# Use fd instead of the default find
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
    fd --type=d --hidden --exclude .git . "$1"
}

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Zoxide
eval "$(zoxide init zsh)"

# Added By PyEnv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Added by Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Added by Toolbox App
export PATH="$PATH:/Users/jackdarlington/Library/Application Support/JetBrains/Toolbox/scripts"

# Added by Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Global NVM Modules
export PATH="$PATH:/Users/jackdarlington/.nvm/versions/node/v21.6.1/lib/node_modules"

# -------
# Aliases
# -------
alias ls="eza" # List files in current directory
alias l="eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions" # List files in current directory in long list format
alias ll="eza -la" # List files in current directory in long list format
alias lt="eza --tree --level=3" # List files in current directory in tree format
alias o="open ." # Open the current directory in Finder
alias cd="z" # Change directory with fuzzy search
alias zz="z -"

# ----------------------
# Git Aliases
# ----------------------
alias gaa='git add .'
alias gcl='git clone'
alias gcm='git commit -m'
alias gpsh='git push'
alias gpll='git pull'
alias gss='git status -s'
alias gsw='git switch'
alias gswc='git switch -c'
alias glo='git log --oneline'
alias gs='echo ""; echo "*********************************************"; echo -e "   DO NOT FORGET TO PULL BEFORE COMMITTING"; echo "*********************************************"; echo ""; git status'

# Activate syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Activate autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# Activate completions
fpath=(path/to/zsh-completions/src $fpath)

# Go Path
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$(go env GOPATH)/bin"

# Herd Lite PHP
export PATH="/Users/jackdarlington/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/Users/jackdarlington/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
