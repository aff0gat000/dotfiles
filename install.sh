#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Helpers ------------------------------------------------------------------

info()  { printf '\033[1;34m[info]\033[0m  %s\n' "$*"; }
warn()  { printf '\033[1;33m[warn]\033[0m  %s\n' "$*"; }
error() { printf '\033[1;31m[error]\033[0m %s\n' "$*"; exit 1; }

command_exists() { command -v "$1" &>/dev/null; }

detect_os() {
  case "$(uname -s)" in
    Linux*)  echo "linux" ;;
    Darwin*) echo "macos" ;;
    *)       error "Unsupported OS: $(uname -s)" ;;
  esac
}

OS="$(detect_os)"

# --- Install dependencies ----------------------------------------------------

install_deps() {
  info "Installing dependencies for $OS..."

  if [ "$OS" = "macos" ]; then
    if ! command_exists brew; then
      info "Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install neovim tmux ripgrep fd node npm git curl
  elif [ "$OS" = "linux" ]; then
    sudo apt-get update
    sudo apt-get install -y neovim tmux ripgrep fd-find nodejs npm git curl build-essential
  fi
}

# --- Symlink configs ----------------------------------------------------------

link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    warn "Backing up existing $dst -> ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  ln -sf "$src" "$dst"
  info "Linked $src -> $dst"
}

setup_nvim() {
  info "Setting up Neovim..."
  link "$DOTFILES_DIR/nvim" "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
}

setup_tmux() {
  info "Setting up tmux..."
  local tmux_conf_dir="${XDG_CONFIG_HOME:-$HOME/.config}/tmux"
  link "$DOTFILES_DIR/tmux/tmux.conf" "$tmux_conf_dir/tmux.conf"
}

# --- Main ---------------------------------------------------------------------

main() {
  info "Dotfiles installer — detected OS: $OS"

  install_deps
  setup_nvim
  setup_tmux

  info "Opening Neovim to install plugins (will exit automatically)..."
  nvim --headless "+Lazy! sync" +qa 2>/dev/null || true

  info "Done! Start nvim and tmux to begin."
}

main "$@"
