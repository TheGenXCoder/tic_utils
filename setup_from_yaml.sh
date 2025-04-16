#!/bin/bash

set -e

CONFIG_FILE="apps.yaml"
TAG_FILTER=""

# Parse tag filter from CLI
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --tag) TAG_FILTER="$2"; shift ;;
  esac
  shift
done

echo "📦 Installing tagged apps (tags: $TAG_FILTER)..."

group_name=""
while IFS= read -r line; do
  if [[ "$line" =~ ^[[:space:]]*-[[:space:]]name:[[:space:]](.+) ]]; then
    group_name="${BASH_REMATCH[1]}"
    echo "🔹 Group: $group_name"
  elif [[ "$line" =~ name:[[:space:]](.+) ]]; then
    app_name="${BASH_REMATCH[1]}"
  elif [[ "$line" =~ command:[[:space:]](.+) ]]; then
    app_command="${BASH_REMATCH[1]}"
  elif [[ "$line" =~ install:[[:space:]](.+) ]]; then
    app_method="${BASH_REMATCH[1]}"
  elif [[ "$line" =~ tags:[[:space:]]*\[(.*)\] ]]; then
    app_tags="${BASH_REMATCH[1]}"
    if [[ -z "$TAG_FILTER" || "$app_tags" == *"$TAG_FILTER"* ]]; then
      echo "Checking/installing: $app_command=$app_name"
      if ! command -v "$app_command" &>/dev/null; then
        echo "$app_command not found, installing $app_name via $app_method"
        case "$app_method" in
          brew) brew install "$app_name" ;;
          brew-cask) brew install --cask "$app_name" ;;
          pacman) sudo pacman -S --noconfirm "$app_name" ;;
          *) echo "No install method defined for $app_name" ;;
        esac
      else
        echo "$app_command is already installed."
      fi
    fi
  fi
done < <(yq e '.groups[] | .name as $group | .apps[] | "name: \(.name)\ncommand: \(.command)\ninstall: \(.install)\ntags: [\(.tags[])]"' "$CONFIG_FILE")
