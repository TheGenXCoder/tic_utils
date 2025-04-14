#!/bin/bash
detect_platform() {
  unameOut="$(uname -s)"
  case "${unameOut}" in
    Linux*) grep -qi arch /etc/os-release && echo "arch" || echo "linux" ;;
    Darwin*) echo "macos" ;;
    *) echo "unknown" ;;
  esac
}
export PLATFORM=$(detect_platform)
