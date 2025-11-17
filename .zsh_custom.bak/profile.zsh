# Set up the Homebrew environment
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/bin:$PATH"

# Zoxide
eval "$(zoxide init zsh)"

# fzf
source <(fzf --zsh)

# fnm
export PATH="/Users/jackdarlington/Library/Application Support/fnm:$PATH"
eval "$(fnm env --use-on-cd --shell zsh)"

# pnpm
export PATH="/Users/jackdarlington/Library/pnpm:$PATH"

# Added by Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Go Path
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$(go env GOPATH)/bin"

# Cargo Path
export PATH="$HOME/.cargo/bin:$PATH"

# Composer
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Add custom local scripts and binaries to PATH
export PATH="$HOME/.local/scripts/:$PATH"
export PATH="$HOME/.local/bin/:$PATH"
