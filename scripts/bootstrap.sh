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
      local -a pkgs=()
      local line
      while IFS= read -r line; do
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        [[ "$line" =~ ^[[:space:]]*$ ]] && continue
        pkgs+=("$line")
      done < "$DOTFILES_DIR/apt-packages.txt"
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
  local os="$1"

  log "Stowing dotfiles"
  require stow

  local profile_dir="$DOTFILES_DIR/profiles"
  local profile="${DOTFILES_PROFILE:-$os}"
  local -a packages=()

  if [[ -n "${DOTFILES_PACKAGES:-}" ]]; then
    # shellcheck disable=SC2206
    packages=(${DOTFILES_PACKAGES})
  elif [[ -f "$profile_dir/$profile" ]]; then
    local line
    while IFS= read -r line; do
      [[ "$line" =~ ^[[:space:]]*# ]] && continue
      [[ "$line" =~ ^[[:space:]]*$ ]] && continue
      packages+=("$line")
    done < "$profile_dir/$profile"
  else
    packages=(git zsh tmux nvim)
    if [[ "$os" == "macos" ]]; then
      packages+=(ghostty karabiner aerospace)
    fi
  fi

  local -a existing=()
  local pkg
  for pkg in "${packages[@]}"; do
    if [[ -d "$DOTFILES_DIR/$pkg" ]]; then
      existing+=("$pkg")
    else
      warn "Dotfiles package not found, skipping: $pkg"
    fi
  done

  if ((${#existing[@]} == 0)); then
    error "No dotfiles packages selected"
  fi

  stow --dir "$DOTFILES_DIR" --target "$HOME" --restow "${existing[@]}"
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
  stow_dotfiles "$os"
  success "Bootstrap complete"
}

main "$@"
