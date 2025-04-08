#! /usr/bin/env nix
#! nix shell nixpkgs#jinja2-cli nixpkgs#jq -c bash

TEMPLATE_PATH=".github/templates"
TEMPLATE_FILE="$TEMPLATE_PATH/README.template.j2"
JSON_FILE="$TEMPLATE_PATH/readme.json"
OUTPUT_FILE="README.md"

SYSTEMS_DIR="systems/x86_64-linux"
HOMES_DIR="homes/x86_64-linux"
CHECKS_DIR="checks"
MODULES_NIX_DIR="modules/nixos"
MODULES_HOME_DIR="modules/home"

extract_comments() {
  local dir="$1"
  local prefix="$2" # Prefix to search for (e.g., TODO, FIXME)
  local comments="{}"

  # Recursively find all files in the directory
  while IFS= read -r -d '' file; do
    # Extract the top-level subdirectory name as the key
    local relative_path="${file#$dir/}"
    local subdir="${relative_path%%/*}"

    # Process the file for comments with the given prefix
    local item_comments
    item_comments=$(echo "$comments" | jq --arg subdir "$subdir" '.[$subdir] // []')

    while IFS= read -r line; do
      if [[ $line =~ \#$prefix\ -\ (.+) ]]; then
        local comment="${BASH_REMATCH[1]}"
        echo "  Found $prefix: $comment" >&2
        item_comments=$(echo "$item_comments" | jq --arg comment "$comment" '. + [$comment]')
      fi
    done <"$file"

    # Update the comments JSON with the new comments for the subdir
    comments=$(echo "$comments" | jq --arg subdir "$subdir" --argjson tasks "$item_comments" '. + {($subdir): $tasks}')
  done < <(find "$dir" -mindepth 2 -type f -print0)

  echo $comments
}

clean_json() {
  local json="$1"
  echo "$json" | jq 'walk(if type == "object" then with_entries(select(.value | length > 0)) else . end)'
}

generate_json() {
  local systems_todos homes_todos checks_todos modules_nix_todos modules_home_todos
  local systems_fixmes homes_fixmes checks_fixmes modules_nix_fixmes modules_home_fixmes

  # Extract TODOs
  systems_todos=$(extract_comments "$SYSTEMS_DIR" "TODO")
  homes_todos=$(extract_comments "$HOMES_DIR" "TODO")
  checks_todos=$(extract_comments "$CHECKS_DIR" "TODO")
  modules_nix_todos=$(extract_comments "$MODULES_NIX_DIR" "TODO")
  modules_home_todos=$(extract_comments "$MODULES_HOME_DIR" "TODO")

  # Extract FIXMEs
  systems_fixmes=$(extract_comments "$SYSTEMS_DIR" "FIXME")
  homes_fixmes=$(extract_comments "$HOMES_DIR" "FIXME")
  checks_fixmes=$(extract_comments "$CHECKS_DIR" "FIXME")
  modules_nix_fixmes=$(extract_comments "$MODULES_NIX_DIR" "FIXME")
  modules_home_fixmes=$(extract_comments "$MODULES_HOME_DIR" "FIXME")

  raw_json=$(jq -n \
      --argjson systems_todos "$systems_todos" \
      --argjson homes_todos "$homes_todos" \
      --argjson checks_todos "$checks_todos" \
      --argjson modules_nix_todos "$modules_nix_todos" \
      --argjson modules_home_todos "$modules_home_todos" \
      --argjson systems_fixmes "$systems_fixmes" \
      --argjson homes_fixmes "$homes_fixmes" \
      --argjson checks_fixmes "$checks_fixmes" \
      --argjson modules_nix_fixmes "$modules_nix_fixmes" \
      --argjson modules_home_fixmes "$modules_home_fixmes" \
      '{
      TODO: {
        Systems: $systems_todos,
        Homes: $homes_todos,
        Checks: $checks_todos,
        ModulesNix: $modules_nix_todos,
        ModulesHome: $modules_home_todos
      },
      FIXME: {
        Systems: $systems_fixmes,
        Homes: $homes_fixmes,
        Checks: $checks_fixmes,
        ModulesNix: $modules_nix_fixmes,
        ModulesHome: $modules_home_fixmes
      }
  } | with_entries(select(.value | keys | length > 0))')

  clean_json "$raw_json" >"$JSON_FILE"
}

# Generate JSON and render the template
generate_json
jinja2 "$TEMPLATE_FILE" "$JSON_FILE" -o "$OUTPUT_FILE"

echo "Rendered $TEMPLATE_FILE to $OUTPUT_FILE"
