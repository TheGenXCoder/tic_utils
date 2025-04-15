#!/bin/bash

echo "cur_dur_dotfiles:$PWD"
DOTFILES_DIR="dotfiles"
DEFAULT_OLD_DOTFILES="$HOME/dotfiles"

restow_dotfiles() {
  echo "📦 Stowing dotfiles from: $DOTFILES_DIR"

  # Step 1: Unstow legacy dotfiles
  if [[ -d "$DEFAULT_OLD_DOTFILES" && "$DEFAULT_OLD_DOTFILES" != "$DOTFILES_DIR" ]]; then
    echo "🧹 Unstowing legacy dotfiles from $DEFAULT_OLD_DOTFILES"
    cd "$DEFAULT_OLD_DOTFILES"
    for d in */; do
      [[ -d "$d" ]] && stow -D "$d"
    done
  fi

  # Step 2: Restow from new DOTFILES_DIR
  if [[ -d "$DOTFILES_DIR" ]]; then
    echo "🔁 Applying stow from $DOTFILES_DIR"
    cd "$DOTFILES_DIR"
    for d in */; do
      [[ -d "$d" ]] && stow "$d"
    done
  else
    echo "❌ Dotfiles directory not found at $DOTFILES_DIR"
    return 1
  fi
}

