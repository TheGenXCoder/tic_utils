#!/bin/bash
DOTFILES_DIR="${DOTFILES:-$HOME/dotfiles}"
DEFAULT_OLD_DOTFILES="$HOME/dotfiles"
restow_dotfiles() {
  if [[ -d "$DEFAULT_OLD_DOTFILES" && "$DOTFILES_DIR" != "$DEFAULT_OLD_DOTFILES" ]]; then
    cd "$DEFAULT_OLD_DOTFILES"
    for d in */; do stow -D "$d"; done
  fi
  if [[ -d "$DOTFILES_DIR" ]]; then
    cd "$DOTFILES_DIR"
    for d in */; do stow "$d"; done
  fi
}