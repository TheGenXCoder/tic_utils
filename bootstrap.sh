#!/bin/bash

set -e

for module in platform.sh installer.sh secrets.sh profiles.sh dotfiles.sh; do
  if [[ ! -f "./$module" ]]; then
    echo "❌ Required module missing: $module"
    exit 1
  fi
  source "./$module"
done

select_profile

echo -e "\n🔐 Loading secrets for profile: $SETUP_PROFILE"
if [[ -f "./secrets.sh" ]]; then
  eval "$(./secrets.sh export --profile "$SETUP_PROFILE")" || echo "⚠️  Failed to load secrets for $SETUP_PROFILE"
else
  echo "⚠️  secrets.sh not found. Skipping secrets."
fi

restow_dotfiles

echo -e "\n🌐 Platform: $PLATFORM"
echo -e "👤 Profile: $SETUP_PROFILE"
echo -e "🏷️ Tags: $TAG_FILTER\n"

if [[ ! -x ./setup_from_yaml.sh ]]; then
  echo "❌ setup_from_yaml.sh not found or not executable."
  exit 1
fi

./setup_from_yaml.sh --tag="$TAG_FILTER"
