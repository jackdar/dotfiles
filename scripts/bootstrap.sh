#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
DOTFILES_DIR="$(cd -- "$SCRIPTS_DIR/.." >/dev/null 2>&1 && pwd)"

source "$SCRIPTS_DIR/utils.sh"

ensure_brew() {
  if has brew; then
    return
  fi

  log "Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  require brew
}

ensure_stow() {
  local os="$1"

  if has stow; then
    return
  fi

  log "Installing stow"
  case "$os" in
  macos)
    ensure_brew
    brew install stow
    ;;
  ubuntu)
    sudo apt-get update
    sudo apt-get install -y stow
    ;;
  *)
    error "Can't install stow automatically for OS: $os"
    ;;
  esac
}

ensure_omz() {
  if ! [[ -d "$HOME/.oh-my-zsh" ]]; then
    log "Installing Oh My Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
}

install_packages() {
  local os="$1"

  case "$os" in
  macos)
    ensure_brew
    if [[ -f "$DOTFILES_DIR/Brewfile" ]]; then
      log "Installing Homebrew packages from Brewfile"
      brew bundle --file "$DOTFILES_DIR/Brewfile"
    else
      warn "No Brewfile found, skipping brew bundle"
    fi
    ;;
  ubuntu)
    if [[ -f "$DOTFILES_DIR/apt-packages.txt" ]]; then
      log "Installing apt packages"
      sudo apt-get update
      mapfile -t pkgs < <(grep -vE '^\s*#|^\s*$' "$DOTFILES_DIR/apt-packages.txt")
      if ((${#pkgs[@]} > 0)); then
        sudo apt-get install -y "${pkgs[@]}"
      fi
    else
      warn "No apt-packages.txt found, skipping apt installs"
    fi
    ;;
  *)
    warn "Unknown OS, skipping package installation"
    ;;
  esac
}

install_manual_packages() {
  local os="$1"

  case "$os" in
  ubuntu)
    log "Installing manual packages"
    for script in "$SCRIPTS_DIR/install/"*.sh; do
      local prog_name
      prog_name="$(basename "$script" ".sh")"

      if has "$prog_name"; then
        inform "$prog_name already installed, skipping"
      else
        inform "Installing $prog_name"
        source "$script"
      fi
    done
    ;;
  esac
}

stow_dotfiles() {
  log "Stowing dotfiles"
  require stow
  stow --dir "$DOTFILES_DIR" --target "$HOME" --restow .
}

main() {
  local os="$(detect_os)"

  case "$os" in
  macos | ubuntu) ;;
  *) error "Unsupported OS. Supported: macOS, Ubuntu/Debian" ;;
  esac

  log "Detected OS: $os"
  ensure_omz
  install_packages "$os"
  install_manual_packages "$os"
  ensure_stow "$os"
  stow_dotfiles
  success "Bootstrap complete"
}

main "$@"
