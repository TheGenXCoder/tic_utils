#!/bin/bash
SECRETS_FILE="secrets.yaml.gpg"
if [[ ! -f "$SECRETS_FILE" ]]; then echo "🔐 No secrets file found."; return 0; fi

gpg --quiet --batch --yes --decrypt "$SECRETS_FILE" |   yq e 'to_entries | .[] | "export \(.key)=\(.value)"' - | while read -r line; do
    eval "$line"
    echo "🔐 Loaded: ${line%%=*}"
done
