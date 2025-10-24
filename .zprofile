if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# fnm
FNM_PATH="/Users/jackdarlington/Library/Application Support/fnm"
if [ -d "$FNM_PATH" ]; then
    export PATH="/Users/jackdarlington/Library/Application Support/fnm:$PATH"
    eval "$(fnm env)"
fi

# pnpm
export PNPM_HOME="/Users/jackdarlington/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Added by Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Go Path
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$(go env GOPATH)/bin"

# Cargo Path
export PATH="$HOME/.cargo/bin:$PATH"

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Bob Neovim Version Manager
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

# Composer
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Add custom local scripts and binaries to PATH
export PATH="$HOME/.local/scripts/:$PATH"
export PATH="$HOME/.local/bin/:$PATH"
