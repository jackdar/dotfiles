# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# fnm
FNM_PATH="/Users/jackdarlington/Library/Application Support/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/Users/jackdarlington/Library/Application Support/fnm:$PATH"
  eval "$(fnm env)"
fi

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

# Add custom local scripts and binaries to PATH
export PATH="$HOME/.local/scripts/:$PATH"
export PATH="$HOME/.local/bin/:$PATH"
