#!/usr/bin/env bash
set -e

HOST="broad"
ISO="$HOST-iso"

SYSTEM="systems/x86_64-linux/$HOST"

if [ -f "$SYSTEM/prebuild.sh" ]; then
  $SYSTEM/prebuild.sh
fi
nix build .#isoConfigurations.$ISO
