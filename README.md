# dotfiles

Personal system dotfiles for macOS and Ubuntu/Debian.

## Quick install (no local clone required first)

You can run the install script directly from GitHub without manually cloning the repo:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/jackdar/dotfiles/master/install.sh)
```

What this does:
- Installs `git` if needed.
- Clones this repo to `~/.dotfiles` (or updates it if it already exists).
- Runs the bootstrap process to install packages and stow dotfiles.

## Update repo + packages

Run the same command again any time you want to update:

```bash
bash ~/.dotfiles/install.sh
```

Re-running `install.sh` will:
- Pull the latest changes from the repo.
- Re-run bootstrap package installation.
- Restow dotfiles.

## Selecting dotfiles to stow

By default, `scripts/bootstrap.sh` stows a small set of packages based on OS.

- Override packages directly:

```bash
DOTFILES_PACKAGES="git zsh tmux nvim" bash ~/.dotfiles/scripts/bootstrap.sh
```

- Use a profile file from `profiles/`:

```bash
DOTFILES_PROFILE=macos bash ~/.dotfiles/scripts/bootstrap.sh
```

## Package management status

- On **macOS**, package installation is handled through Homebrew (`brew bundle` with `Brewfile`).
- On **Ubuntu**, package installation is currently a mix of `apt` packages plus manual install scripts.
- **Planned:** macOS will also get some manual install scripts soon.
