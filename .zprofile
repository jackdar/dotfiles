typeset -U path PATH

if [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

path+=("$HOME/.local/bin")
path+=("$HOME/.local/scripts")
path+=("$HOME/.opencode/bin")

if [[ $OSTYPE == "darwin"* ]]; then
  path+=("/Applications/Obsidian.app/Contents/MacOS")
fi
path+=("/usr/local/go/bin")
path+=("/usr/local/zig")
