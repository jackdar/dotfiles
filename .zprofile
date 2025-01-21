# Set up the Homebrew environment
eval "$(/opt/homebrew/bin/brew shellenv)"

# fzf
source <(fzf --zsh)

# Zoxide
eval "$(zoxide init zsh)"

# PyEnv
eval "$(pyenv init -)"
