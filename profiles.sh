#!/bin/bash
select_profile() {
  echo "📁 Available Profiles:"
  yq e '.profiles[].name' profiles.yaml | nl -w2 -s'. '
  read -p "Select a profile number: " n
  export SETUP_PROFILE=$(yq e ".profiles[$((n-1))].name" profiles.yaml)
  export TAG_FILTER=$(yq e ".profiles[$((n-1))].tags[]" profiles.yaml | xargs)
}
