#!/usr/bin/env nix-shell
#!nix-shell --quiet -i zsh -p nh

# Function to get the current generation
get_gen() {
    sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | awk '/current/ {print $1}'
}



# Get branch name 
branch=$(git branch --show-current)

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
case "$branch" in
    main)
        nh os switch .
        ;;
    dev)
        nh os test .
        ;;
    *)
        # Default commands for any other branch
        echo "ERROR: Unknown branch!"
        git reset -q HEAD~
        exit 1
        ;;
esac

# If nixos-rebuild fails, undo the commit and exit
if [ $? -ne 0 ]; then
    git reset -q HEAD~
    exit 1
fi

# Create tag and push
case "$branch" in
    main)
        new_gen=$(get_gen)
        git tag -f "gen-$new_gen" -m "NixOS configuration for generation $new_gen"
        ;;
    dev)
        git tag -f "dev" -m "NixOS configuration in development"
        ;;
    *)
        # Default commands for any other branch
        echo "ERROR: Unknown branch!"
        git reset -q HEAD~
        exit 1
        ;;
esac
git push -fq --follow-tags

exit 0
