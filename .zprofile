typeset -U path PATH

if [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

path+=("$HOME/.local/bin")
path+=("$HOME/.local/scripts")
path+=("$HOME/.opencode/bin")
path+=("$HOME/.config/composer/vendor/bin")

[ -d "$HOME/.local/bachcare" ] && path+=("$HOME/.local/bachcare/")

path+=("/usr/local/go/bin")
path+=("/usr/local/zig")
