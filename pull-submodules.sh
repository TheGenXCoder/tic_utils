#!/bin/bash
echo "🔄 Updating submodules recursively..."
git submodule update --init --recursive
git submodule foreach --recursive git pull origin master
echo "✅ Submodules updated."
