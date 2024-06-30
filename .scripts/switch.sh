#!/usr/bin/env nix-shell
#!nix-shell --quiet -i zsh -p nh

# Function to get the current generation
get_gen() {
    sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | awk '/current/ {print $1}'
}



# Lock flake inputs
nix flake lock --option warn-dirty false

# Commit all changes
git add .
git commit -aq --allow-empty

# If commit fails, exit
if [ $? -ne 0 ]; then
    exit 1
fi

# Run nixos-rebuild
nh os switch .

# If nixos-rebuild fails, undo the commit and exit
if [ $? -ne 0 ]; then
    git reset -q HEAD~
    exit 1
fi

# Get the new current generation
new_gen=$(get_gen)

# Create tag and push
git tag -f "gen-$new_gen" -m "NixOS configuration for generation $new_gen"
git push -fq --follow-tags

exit 0
