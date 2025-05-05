#! /usr/bin/env nix
#! nix shell nixpkgs#compose2nix -c bash

HOST="broad"

SERVICES_DIR="systems/x86_64-linux/$HOST/services"

COMPOSE_FILES=$(find $SERVICES_DIR -type f -name "compose.yaml" -printf "%p,")

compose2nix \
  -project=$HOST \
  -output=$SERVICES_DIR/compose.nix \
  -inputs=${COMPOSE_FILES%,} \
  -include_env_files=true
