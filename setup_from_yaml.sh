#!/bin/bash
CONFIG_FILE="apps.yaml"
TAG_FILTER=""
while [[ "$1" =~ ^--tag ]]; do shift; TAG_FILTER="$1"; shift; done
echo "📦 Installing (tags: $TAG_FILTER)..."
yq e '.groups[].apps[]' "$CONFIG_FILE" | while read -r app; do echo "$app" > /dev/null; done
