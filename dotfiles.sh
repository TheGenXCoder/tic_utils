#!/bin/bash
DOTFILES_DIR="$HOME/dotfiles"
restow_dotfiles() {
  cd "$DOTFILES_DIR" && for d in */; do stow "$d"; done
}