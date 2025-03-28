# Added By PyEnv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

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

# Go Path
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$(go env GOPATH)/bin"

# Herd Lite PHP
export PATH="$HOME/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# Add custom local scripts to PATH
export PATH="$HOME/.local/scripts/:$PATH"
