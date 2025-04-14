#!/bin/bash
PROFILE_FILE="profiles.yaml"
select_profile() {
  [[ ! -f "$PROFILE_FILE" ]] && echo "⚠️ No profile file found" && return

  echo "📁 Available Profiles:"
  yq e '.profiles[].name' "$PROFILE_FILE" | nl -w2 -s'. '

  read -p "Select a profile number: " profile_number
  PROFILE_NAME=$(yq e ".profiles[$((profile_number - 1))].name" "$PROFILE_FILE")
  PROFILE_TAGS=$(yq e ".profiles[$((profile_number - 1))].tags[]" "$PROFILE_FILE" | xargs)

  echo "✅ Selected profile: $PROFILE_NAME"
  echo "🏷️ Tags: $PROFILE_TAGS"
  export SETUP_PROFILE="$PROFILE_NAME"
  export TAG_FILTER="$PROFILE_TAGS"
}
