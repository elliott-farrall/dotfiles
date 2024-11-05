#! /usr/bin/env nix-shell
#! nix-shell -i bash -p compose2nix

array_to_comma_separated() {
  local array=("$@")
  local IFS=','
  echo "${array[*]}"
}

HOST="broad"

SERVICES_DIR=$(dirname $0)

mapfile -t COMPOSE_FILES < <(find $SERVICES_DIR -type f -name compose.yaml)

nix run github:aksiksi/compose2nix -- \
  -project=$HOST \
  -output=$SERVICES_DIR/compose.nix \
  -inputs=$(array_to_comma_separated ${COMPOSE_FILES[@]}) \
  -include_env_files=true
