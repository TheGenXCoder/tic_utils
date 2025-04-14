#!/bin/bash

REPO_DIR="$HOME/.bootstrap"
REPO_URL="https://github.com/yourusername/dotfiles-bootstrap.git"
BRANCH="main"

if [[ -d "$REPO_DIR/.git" ]]; then
  echo "🔄 Pulling latest changes from $REPO_URL..."
  git -C "$REPO_DIR" pull origin "$BRANCH"
else
  echo "📦 Cloning fresh copy of $REPO_URL..."
  git clone --depth=1 --branch "$BRANCH" "$REPO_URL" "$REPO_DIR"
fi

cd "$REPO_DIR"
chmod +x *.sh
./bootstrap.sh
