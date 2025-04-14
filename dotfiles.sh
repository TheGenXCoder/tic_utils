#!/bin/bash
DOTFILES_DIR="${DOTFILES:-$HOME/dotfiles}"
DEFAULT_OLD_DOTFILES="$HOME/dotfiles"

restow_dotfiles() {
  if [[ -d "$DEFAULT_OLD_DOTFILES" && "$DOTFILES_DIR" != "$DEFAULT_OLD_DOTFILES" ]]; then
    echo "🧹 Unstowing legacy dotfiles from $DEFAULT_OLD_DOTFILES"
    cd "$DEFAULT_OLD_DOTFILES"
    for d in */; do stow -D "$d"; done
  fi

  if [[ -d "$DOTFILES_DIR" ]]; then
    echo "🔁 Stowing from $DOTFILES_DIR"
    cd "$DOTFILES_DIR"
    for d in */; do stow "$d"; done
  fi
}
