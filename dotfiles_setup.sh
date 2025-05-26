#!/bin/bash

# Exit the script on any error
set -e

# Define dotfiles repository
DOTFILES_REPO="https://github.com/jackdar/dotfiles"
DOTFILES_DIR="$HOME/.dotfiles"
BREWFILE="$HOME/.dotfiles/Brewfile" # Path to brewfile listing additional packages

# Define function to install Homebrew
install_homebrew() {
    if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Add Homebrew to PATH for the current session
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        echo "Homebrew is already installed."
    fi
}

# Install Homebrew, Git, and Stow
install_homebrew
install_package git
install_package stow

# Clone the dotfiles repository if it doesn't exist
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Cloning dotfiles repository..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
    echo "Dotfiles repository already exists. Pulling latest changes..."
    git -C "$DOTFILES_DIR" pull
fi

# Install additional packages from Brewfile if it exists
if [ -f "$BREWFILE" ]; then
    echo "Installing additional packages from $BREWFILE..."
    brew bundle --file="$BREWFILE"
else
    echo "No Brewfile found at $BREWFILE. Skipping additional package installation."
fi

# Run stow to symlink dotfiles
echo "Running stow to symlink dotfiles..."
cd "$DOTFILES_DIR"
stow .

# Symlink specific configuration files
ln -s "$DOTFILES_DIR/.config/tmux/tmux.conf" "$HOME/.tmux.conf"

echo "Dotfile setup complete!"
