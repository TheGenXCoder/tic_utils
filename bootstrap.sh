#!/bin/bash

# Load utilities
source ./platform.sh
source ./installer.sh
source ./secrets.sh
source ./profiles.sh
source ./dotfiles.sh

select_profile
restow_dotfiles

echo -e "\n🌐 Platform: $PLATFORM"
echo -e "👤 Profile: $SETUP_PROFILE"
echo -e "🏷️ Tags: $TAG_FILTER\n"

./setup_from_yaml.sh --tag="$TAG_FILTER"
