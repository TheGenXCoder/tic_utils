#!/bin/bash
DOTFILES_DIR="${DOTFILES:-$HOME/dotfiles}"
STOW_TARGET="$HOME"

usage() { echo "Usage: dotman.sh <stow|unstow|status>"; exit 1; }

list_dotfiles() {
  [[ -d "$DOTFILES_DIR" ]] || { echo "❌ Not found: $DOTFILES_DIR"; exit 1; }
  (cd "$DOTFILES_DIR" && find . -maxdepth 1 -type d ! -name "." -exec basename {} ';')
}

dotman_stow() { echo "📦 Stowing..."; for d in $(list_dotfiles); do echo "  stow $d"; stow -d "$DOTFILES_DIR" -t "$STOW_TARGET" "$d"; done }
dotman_unstow() { echo "🧹 Unstowing..."; for d in $(list_dotfiles); do echo "  unstow $d"; stow -D -d "$DOTFILES_DIR" -t "$STOW_TARGET" "$d"; done }
dotman_status() { echo "🔍 Linked:"; find "$HOME" -type l -lname "$DOTFILES_DIR/*" 2>/dev/null; }

case "$1" in stow) dotman_stow ;; unstow) dotman_unstow ;; status) dotman_status ;; *) usage ;; esac
