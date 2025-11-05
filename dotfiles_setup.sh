#!/usr/bin/env bash

# Exit the script on any error
set -e

# Get the operating system (Darwin or GNU/Linux)
OS="$(uname -s)"

# Define dotfiles repository
DOTFILES_REPO="https://github.com/jackdar/dotfiles"
DOTFILES_DIR="$HOME/.dotfiles"

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

# Define function to install the Xcode command line tools
install_xcode_cli() {
    if ! xcode-select -p &>/dev/null; then
        echo "Installing Xcode Command Line Tools..."
        xcode-select --install
        # Wait until the Xcode Command Line Tools are installed
        until xcode-select -p &>/dev/null; do
            sleep 5
        done
        echo "Xcode Command Line Tools installed."
    else
        echo "Xcode Command Line Tools are already installed."
    fi
}

# Install additional packages from Brewfile if it exists
run_brewfile() {
    if [ -f "$BREWFILE" ]; then
        echo "Installing additional packages from $BREWFILE..."
        brew bundle --file="$BREWFILE"
    else
        echo "No Brewfile found at $BREWFILE. Skipping additional package installation."
    fi
}

# Define an argument to run the script with to get latest dotfiles before running
if [ "$1" == "--update" ]; then
    # Clone the dotfiles repository if it doesn't exist
    get_dotfiles() {
        if [ ! -d "$DOTFILES_DIR" ]; then
            echo "Cloning dotfiles repository..."
            git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
        else
            echo "Dotfiles repository already exists. Pulling latest changes..."
            git -C "$DOTFILES_DIR" pull
        fi
    }

    if [ -d "$DOTFILES_DIR" ]; then
        echo "Updating dotfiles repository..."
        get_dotfiles
        echo "Dotfiles updated. Exiting."
        exit 0
    fi
    exit 1
fi

if [ "$OS" == "Darwin" ]; then
    BREWFILE="$HOME/.dotfiles/Brewfile" # Path to brewfile listing additional packages

    # Install dependencies
    install_homebrew
    install_xcode_cli
    run_brewfile

    # Run stow to symlink dotfiles
    echo "Running stow to symlink dotfiles..."
    cd "$DOTFILES_DIR"
    stow .

    # Symlink specific configuration files
    ln -s "$DOTFILES_DIR/.config/tmux/tmux.conf" "$HOME/.tmux.conf"

    echo "Dotfile setup complete!"
    exit 0
else
    echo "Unsupported operating system: $OS"
    exit 1
fi
