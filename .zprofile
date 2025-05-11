# Set up the Homebrew environment
eval "$(/opt/homebrew/bin/brew shellenv)"

# fzf
source <(fzf --zsh)

#fnm
eval "$(fnm env --use-on-cd --shell zsh)"

# Zoxide
eval "$(zoxide init zsh)"
