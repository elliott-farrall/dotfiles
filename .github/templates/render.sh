#! /usr/bin/env nix
#! nix shell
#! nix nixpkgs#jq
#! nix nixpkgs#jinja2-cli
#! nix nixpkgs#python312Packages.pre-commit-hooks
#! nix --command bash

TEMPLATE_PATH=".github/templates"
TEMPLATE_FILE="$TEMPLATE_PATH/README.template.j2"
JSON_FILE="$TEMPLATE_PATH/readme.json"
OUTPUT_FILE="README.md"

# Map top-level directories to JSON keys
declare -A DIR_TO_KEY=(
  ["checks"]="Checks"
  ["homes/x86_64-linux"]="Homes"
  ["modules/home"]="ModulesHome"
  ["modules/nixos"]="ModulesNix"
  ["packages"]="Packages"
  ["overlays"]="Overlays"
  ["shells"]="Shells"
  ["systems/x86_64-linux"]="Systems"
)

extract_comments() {
  local file="$1"
  local prefix="$2" # Prefix to search for (e.g., TODO, FIXME)

  local comments="[]"
  while IFS= read -r line; do
    if [[ $line =~ \#$prefix\ -\ (.+) ]]; then
      # Extract comment
      local comment="${BASH_REMATCH[1]}"
      echo "  Found $prefix in $file: $comment" >&2
      comments=$(echo "$comments" | jq --arg comment "$comment" '. + [$comment]')
    fi
  done <"$file"

  echo "$comments" | jq '.'
}

process_file() {
  local file="$1"

  # Extract the relative path
  local relative_path="${file#./}"

  # Match the start of the relative path with DIR_TO_KEY
  local key=""
  for dir in "${!DIR_TO_KEY[@]}"; do
    if [[ "$relative_path" == "$dir"* ]]; then
      key="${DIR_TO_KEY["$dir"]}"
      break
    fi
  done
  if [[ -z "$key" ]]; then
    echo "  Skipping $file: No mapping for $relative_path" >&2
    echo '{"TODO": {}, "FIXME": {}}'
    return
  fi

  # Extract the subdirectory (remaining part of the path after the matched directory)
  local subdir="${relative_path#"$dir/"}"
  subdir="${subdir%%/*}"

  # Extract TODOs and FIXMEs
  local file_todos file_fixmes
  file_todos=$(extract_comments "$file" "TODO")
  file_fixmes=$(extract_comments "$file" "FIXME")

  # Add comments to the JSON structure
  local todos="{}"
  local fixmes="{}"
  if [[ -n "$file_todos" && "$file_todos" != "[]" ]]; then
    todos=$(echo "$todos" | jq --arg key "$key" --arg subdir "$subdir" --argjson comments "$file_todos" '.[$key][$subdir] = $comments')
  fi
  if [[ -n "$file_fixmes" && "$file_fixmes" != "[]" ]]; then
    fixmes=$(echo "$fixmes" | jq --arg key "$key" --arg subdir "$subdir" --argjson comments "$file_fixmes" '.[$key][$subdir] = $comments')
  fi

  jq -n --argjson todos "$todos" --argjson fixmes "$fixmes" '{TODO: $todos, FIXME: $fixmes}'
}

generate_json() {
  local raw_json='{"TODO": {}, "FIXME": {}}'

  # Find all files in the directories specified in DIR_TO_KEY
  local files=()
  for dir in "${!DIR_TO_KEY[@]}"; do
    while IFS= read -r file; do
      files+=("$file")
    done < <(find "$dir" -type f)
  done

  for file in "${files[@]}"; do
    if [[ -f "$file" ]]; then
      local file_json
      file_json=$(process_file "$file")

      # Merge file JSON into the global JSON
      raw_json=$(echo -e "$raw_json\n$file_json" | jq -s 'reduce .[] as $item ({}; . * $item)')
    fi
  done

  echo "$raw_json" | jq '.'
}

echo "Generating JSON..."
generate_json > "$JSON_FILE"
jinja2 "$TEMPLATE_FILE" "$JSON_FILE" -o "$OUTPUT_FILE"
end-of-file-fixer "$OUTPUT_FILE"
echo "Rendered $TEMPLATE_FILE to $OUTPUT_FILE"
