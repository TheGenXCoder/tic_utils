#!/bin/bash

COMMAND=$1
shift

case "$COMMAND" in
  bootstrap)
    ./bootstrap.sh "$@"
    ;;
  secrets)
    ./secrets.sh "$@"
    ;;
  dotfiles)
    ./dotman.sh "$@"
    ;;
  vault)
    ./secrets.sh vault "$@"
    ;;
  help|"")
    echo "tic - dotfiles bootstrap CLI"
    echo ""
    echo "Usage:"
    echo "  tic bootstrap              # Run full system bootstrap"
    echo "  tic secrets <args>         # Manage secrets (GPG or Vault)"
    echo "  tic dotfiles <args>        # Manage dotfiles (stow/unstow/status)"
    echo "  tic vault <args>           # Use Vault secrets backend (TBD)"
    echo ""
    ;;
  *)
    echo "❌ Unknown command: $COMMAND"
    exit 1
    ;;
esac
