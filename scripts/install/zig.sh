#!/usr/bin/env bash

_install_zig() {
  local os="$(uname -m | sed 's/^arm64$/aarch64/')-$(uname | sed 's/.*/\L&/' | sed 's/darwin/macos/')"
  local tar=$(curl -sL https://ziglang.org/download/index.json |
    jq -r --arg os "$os" 'keys_unsorted[1] as $v | .[$v][$os].tarball')

  download $tar && extract $(basename "$tar")

  sudo rm -rf /usr/local/zig
  sudo mv $(basename "$tar" ".tar.xz") /usr/local/zig
}

with_temp_dir _install_zig
