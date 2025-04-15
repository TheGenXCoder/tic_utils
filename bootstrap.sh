#!/bin/bash
echo "cur_dur_bootstrap:$PWD"
set -e

# Load components
for module in platform.sh installer.sh secrets.sh profiles.sh dotfiles.sh; do
  if [[ ! -f "./$module" ]]; then
    echo "❌ Required file missing: $module"
    exit 1
  fi
  source "./$module"
done

# Profile + dotfiles
select_profile
restow_dotfiles

# Debug summary
echo -e "\n🌐 Platform: $PLATFORM"
echo -e "👤 Profile: $SETUP_PROFILE"
echo -e "🏷️ Tags: $TAG_FILTER\n"

# Run setup
if [[ ! -x $SETUPDIR/setup_from_yaml.sh ]]; then
  echo "❌ setup_from_yaml.sh is missing or not executable."
  exit 1
fi

echo "cur_dur_call_setup:$PWD"
$SETUPDIR/setup_from_yaml.sh --tag="$TAG_FILTER"
