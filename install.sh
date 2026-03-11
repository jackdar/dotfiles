#!/usr/bin/env bash
set -euo pipefail

DOTFILES_REPO_URL="${DOTFILES_REPO_URL:-https://github.com/jackdar/dotfiles.git}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

ensure_git() {
  if command -v git >/dev/null 2>&1; then
    return
  fi

  if [[ "$(uname -s)" == "Darwin" ]]; then
    printf "Installing Xcode Command Line Tools (includes git)...\n"
    xcode-select --install || true
    printf "Finish Xcode tools installation, then rerun this script.\n"
    exit 1
  elif [[ -r /etc/os-release ]]; then
    . /etc/os-release

    if [[ "${ID:-}" == "ubuntu" || "${ID:-}" == "debian" || "${ID_LIKE:-}" == *"debian"* ]]; then
      if [[ "${EUID:-$(id -u)}" -eq 0 ]]; then
        apt-get update
        apt-get install -y git
      else
        sudo apt-get update
        sudo apt-get install -y git
      fi
    else
      printf "Unsupported OS for automatic git install.\n" >&2
      exit 1
    fi
  else
    printf "Unsupported OS for automatic git install.\n" >&2
    exit 1
  fi

  command -v git >/dev/null 2>&1 || {
    printf "git installation failed\n" >&2
    exit 1
  }
}

ensure_git

if [[ -d "$DOTFILES_DIR/.git" ]]; then
  printf "Checking for updates at %s...\n" "$DOTFILES_DIR"
  git -C "$DOTFILES_DIR" pull --ff-only
else
  if [[ -e "$DOTFILES_DIR" ]]; then
    printf "%s exists but is not a git repository\n" "$DOTFILES_DIR" >&2
    exit 1
  fi

  printf "Cloning dotfiles into %s\n" "$DOTFILES_DIR"
  git clone --recurse-submodules "$DOTFILES_REPO_URL" "$DOTFILES_DIR"
fi

bash "$DOTFILES_DIR/scripts/bootstrap.sh"
