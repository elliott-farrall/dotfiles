#! /usr/bin/env nix
#! nix shell github:tomberek/-#python3With.jinja2 -c python3

import os
import re
import sys
import argparse
from pathlib import Path
from jinja2 import Template

# Map top-level directories to JSON keys
DIR_TO_KEY = {
    "checks": "Checks",
    "homes/x86_64-linux": "Homes",
    "modules/home": "ModulesHome",
    "modules/nixos": "ModulesNix",
    "packages": "Packages",
    "overlays": "Overlays",
    "shells": "Shells",
    "systems/x86_64-linux": "Systems",
}

def extract_comments(file_path, prefix):
    """
    Extract comments with a specific prefix (e.g., TODO, FIXME) from a file.
    Handles files with invalid UTF-8 characters gracefully.
    """
    comments = []
    with open(file_path, "rb") as file:  # Open in binary mode
        for line in file:
            try:
                # Decode the line, ignoring invalid characters
                line = line.decode("utf-8", errors="ignore")
                # Match comments anywhere in the line
                match = re.search(rf"#.*\b{prefix}\b\s*-\s*(.+)", line)
                if match:
                    comment = match.group(1)
                    print(f"  Found {prefix} in {file_path}: {comment}")
                    comments.append(comment)
            except UnicodeDecodeError:
                print(f"  Skipping invalid line in {file_path}")
    return comments

def process_file(file_path):
    """
    Process a single file to extract TODO and FIXME comments and organize them into JSON.
    """
    # Normalize the relative path
    relative_path = os.path.relpath(file_path)
    key = None

    # Match the start of the relative path with DIR_TO_KEY
    for dir_path, dir_key in DIR_TO_KEY.items():
        # Normalize the directory path for comparison
        normalized_dir_path = os.path.normpath(dir_path)
        if relative_path.startswith(normalized_dir_path):
            key = dir_key
            break

    if not key:
        print(f"  Skipping {file_path}: No mapping for {relative_path}")
        return {"TODO": {}, "FIXME": {}}

    # Extract the subdirectory (remaining part of the path after the matched directory)
    subdir = relative_path[len(normalized_dir_path):].lstrip("/").split("/")[0]

    # Extract TODOs and FIXMEs
    todos = extract_comments(file_path, "TODO")
    fixmes = extract_comments(file_path, "FIXME")

    # Add comments to the JSON structure
    result = {"TODO": {}, "FIXME": {}}
    if todos:
        result["TODO"].setdefault(key, {}).setdefault(subdir, []).extend(todos)
    if fixmes:
        result["FIXME"].setdefault(key, {}).setdefault(subdir, []).extend(fixmes)

    return result

def generate_json():
    """
    Generate a JSON object by processing all files in the specified directories.
    """
    raw_json = {"TODO": {}, "FIXME": {}}

    for dir_path, dir_key in DIR_TO_KEY.items():
        if not os.path.isdir(dir_path):
            print(f"Skipping non-existent directory: {dir_path}")
            continue

        for root, _, files in os.walk(dir_path):
            for file_name in files:
                file_path = os.path.join(root, file_name)
                file_json = process_file(file_path)

                # Merge file JSON into the global JSON
                for key in ["TODO", "FIXME"]:
                    for sub_key, sub_value in file_json[key].items():
                        if sub_key not in raw_json[key]:
                            raw_json[key][sub_key] = {}
                        for subdir, comments in sub_value.items():
                            if subdir not in raw_json[key][sub_key]:
                                raw_json[key][sub_key][subdir] = []
                            raw_json[key][sub_key][subdir].extend(comments)

    return raw_json

def render_template(template_file, json_data, output_file):
    """
    Render the Jinja2 template using the generated JSON data.
    """
    with open(template_file, "r") as template_fp:
        template = Template(template_fp.read())

    rendered_content = template.render(json_data)

    with open(output_file, "w") as output_fp:
        output_fp.write(rendered_content)

def main():
    parser = argparse.ArgumentParser(description="Render a Jinja2 template with extracted JSON data.")
    parser.add_argument("-t", "--template", required=True, help="Path to the Jinja2 template file.")
    parser.add_argument("-o", "--output", required=True, help="Path to the output file.")

    args = parser.parse_args()
    template_file = args.template
    output_file = args.output

    print("Generating JSON...")
    json_data = generate_json()

    # Render the template directly with the generated JSON data
    render_template(template_file, json_data, output_file)

    # Ensure the output file ends with a newline
    with open(output_file, "a") as output_fp:
        output_fp.write("\n")

    print(f"Rendered {template_file} to {output_file}")

if __name__ == "__main__":
    main()
