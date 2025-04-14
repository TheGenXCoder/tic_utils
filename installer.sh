#!/bin/bash
install_package() {
  local name="$1"
  local type="$2"
  local cmd="$3"

  if [[ -n "$cmd" && $(command -v "$cmd" 2>/dev/null) ]]; then
    echo "✔️ $cmd is already installed."
    return 0
  fi

  echo "Installing $name via $type..."

  case "$PLATFORM" in
    macos)
      case "$type" in
        brew) brew install "$name" ;;
        cask) brew install --cask "$name" ;;
        dmg) echo "[TODO: DMG support]" ;;
        make) (cd "$name" && make install) ;;
        *) echo "Unknown installer: $type" ;;
      esac
      ;;
    arch)
      case "$type" in
        pacman) sudo pacman -S --noconfirm "$name" ;;
        yay) yay -S --noconfirm "$name" ;;
        *) echo "Unknown Arch installer: $type" ;;
      esac
      ;;
  esac
}
