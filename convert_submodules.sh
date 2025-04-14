#!/bin/bash

PLUGIN_DIR="${1:-tmux/.config/tmux/plugins}"

if [[ ! -d "$PLUGIN_DIR" ]]; then
  echo "❌ Plugin directory not found: $PLUGIN_DIR"
  exit 1
fi

cd "$PLUGIN_DIR" || exit 1

for plugin in */; do
  plugin=${plugin%/}
  plugin_path="$PLUGIN_DIR/$plugin"

  echo "🔍 Checking $plugin..."

  if git config -f .gitmodules --get-regexp path | grep -q "$plugin"; then
    echo "✅ $plugin is already a submodule"
    continue
  fi

  if [[ -d "$plugin/.git" || -f "$plugin/.git" ]]; then
    guessed_url=$(git -C "$plugin" config --get remote.origin.url)
    if [[ -n "$guessed_url" ]]; then
      echo "🌐 Found remote URL: $guessed_url"
    fi

    read -p "Enter git URL for '$plugin' [default: $guessed_url]: " remote_url
    remote_url="${remote_url:-$guessed_url}"

    if [[ -z "$remote_url" ]]; then
      echo "⏩ Skipping $plugin"
      continue
    fi

    git rm -r --cached "$plugin"
    rm -rf "$plugin"
    git submodule add "$remote_url" "$plugin"
    continue
  fi

  echo "⏩ Skipping $plugin (not a git repo)"
done

echo "✅ Plugin submodule conversion complete."
