#!/bin/bash
echo "cur_dur_setup:$PWD"
CONFIG="apps.yaml"
TAG_FILTER=""
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --tag=*) TAG_FILTER="${1#*=}" ;;
  esac
  shift
done

if [[ ! -f "$CONFIG" ]]; then echo "Config $CONFIG not found."; exit 1; fi

if ! command -v yq &>/dev/null; then
  echo "yq is required but not installed. Please install it first."
  exit 1
fi

echo "🔍 Parsing setup config..."
groups=$(yq e '.groups[].name' "$CONFIG")

for group in $groups; do
  echo "💻 Installing $group..."
  apps=$(yq e ".groups[] | select(.name == \"$group\") | .apps[]" "$CONFIG")

  for i in $(yq e ".groups[] | select(.name == \"$group\") | .apps | length" "$CONFIG"); do
    name=$(yq e ".groups[] | select(.name == \"$group\") | .apps[$i].name" "$CONFIG")
    command=$(yq e ".groups[] | select(.name == \"$group\") | .apps[$i].command" "$CONFIG")
    method=$(yq e ".groups[] | select(.name == \"$group\") | .apps[$i].install" "$CONFIG")
    tags=$(yq e ".groups[] | select(.name == \"$group\") | .apps[$i].tags[]" "$CONFIG" | xargs)

    if [[ -n "$TAG_FILTER" && ! "$tags" =~ $TAG_FILTER ]]; then
      echo "⏩ Skipping $name due to tag mismatch"
      continue
    fi

    echo "Checking/installing: $name=$command"
    if ! command -v "$command" &>/dev/null; then
      install_package "$name" "$method" "$command"
    else
      echo "$name is already installed."
    fi

    DOTFILES_PATH="$DOTFILES_DIR/$name"
    if [[ -d "$DOTFILES_PATH" ]]; then
      echo "Linking dotfiles for $name"
      stow -d "$DOTFILES_DIR" "$name"
    else
      echo "No dotfiles directory found for $name."
    fi
  done
done
echo "🎯 Setup complete."
