#!/usr/bin/env bash
set -euo pipefail

# --- Terminal colours ---

if [[ -t 1 ]]; then
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  YELLOW='\033[0;33m'
  BLUE='\033[0;34m'
  MAGENTA='\033[0;35m'
  CYAN='\033[0;36m'
  BOLD='\033[1m'
  RESET='\033[0m'
else
  RED=''
  GREEN=''
  YELLOW=''
  BLUE=''
  MAGENTA=''
  CYAN=''
  BOLD=''
  RESET=''
fi

# --- Logging ---

log() { printf "\n${BOLD}${BLUE}==> %s${RESET}\n" "$*"; }

inform() { printf "${CYAN}  ->${RESET} %s\n" "$*"; }

success() { printf "${GREEN}  ✓${RESET} %s\n" "$*"; }

warn() { printf "${YELLOW}  !${RESET} %s\n" "$*" >&2; }

error() {
  printf "${RED}  ✗ %s${RESET}\n" "$*" >&2
  exit 1
}

# --- Command helpers ---

has() {
  command -v "$1" >/dev/null 2>&1
}

require() {
  has "$1" || error "Missing require command: $1"
}

with_temp_dir() {
  local tmp
  tmp="$(mktemp -d)"

  (
    cd "$tmp" || exit 1
    "$@"
  )

  rm -rf "$tmp"
}

download() {
  local url="$1"
  local out="${2:-$(basename "$url")}"

  if has curl; then
    curl -fsSL "$url" -o "$out"
  elif has wget; then
    wget -q "$url" -O "$out"
  else
    error "curl or wget required"
  fi
}

extract() {
  case "$1" in
  *.tar.gz | *.tgz) tar -xzf "$1" ;;
  *.tar.xz) tar -xJf "$1" ;;
  *.tar.bz2) tar -xjf "$1" ;;
  *.zip) unzip "$1" ;;
  *) error "Cannot extract $1" ;;
  esac
}

# --- OS ---

is_macos() { [[ "$(uname -s)" == "Darwin" ]]; }
is_linux() { [[ "$(uname -s)" == "Linux" ]]; }

linux_like() {
  if [[ -r /etc/os-release ]]; then
    . /etc/os-release
    echo "${ID_LIKE:-}"
  else
    echo ""
  fi
}

detect_aur_helper() {
  if has paru; then
    echo "paru"
  elif has yay; then
    echo "yay"
  else
    echo ""
  fi
}

detect_os() {
  local id like
  id=""
  like=""

  if is_macos; then
    echo "macos"
    return
  fi

  if is_linux; then
    like="$(linux_like)"
    if [[ -r /etc/os-release ]]; then
      # shellcheck disable=SC1091
      . /etc/os-release
      id="${ID:-}"
    fi

    case "$id" in
    ubuntu | debian) echo "ubuntu" ;;
    arch) echo "arch" ;;
    *)
      if [[ "$like" == *"debian"* ]]; then
        echo "ubuntu"
      elif [[ "$like" == *"arch"* ]]; then
        echo "arch"
      else
        echo "unknown"
      fi
      ;;
    esac
    return
  fi

  echo "unknown"
}
