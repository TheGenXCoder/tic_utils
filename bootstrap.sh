#!/bin/bash
set -e
for f in platform.sh installer.sh secrets.sh profiles.sh dotfiles.sh; do source "./$f"; done
select_profile
echo "🔐 Loading secrets for profile: $SETUP_PROFILE"
eval "$(./secrets.sh export --profile "$SETUP_PROFILE")" || echo "⚠️  Secrets load failed"
restow_dotfiles
echo -e "🌍 Platform: $PLATFORM\n👤 Profile: $SETUP_PROFILE\n🏷️ Tags: $TAG_FILTER"
./setup_from_yaml.sh --tag="$TAG_FILTER"
