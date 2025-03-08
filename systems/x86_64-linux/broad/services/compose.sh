#! /usr/bin/env nix
#! nix shell nixpkgs#compose2nix -c bash

array_to_comma_separated() {
  local array=("$@")
  local IFS=','
  echo "${array[*]}"
}

HOST="broad"

SERVICES_DIR=$(dirname $0)

mapfile -t COMPOSE_FILES < <(find $SERVICES_DIR -type f -name compose.yaml)

compose2nix -- \
  -project=$HOST \
  -output=$SERVICES_DIR/compose.nix \
  -inputs=$(array_to_comma_separated ${COMPOSE_FILES[@]}) \
  -include_env_files=true
