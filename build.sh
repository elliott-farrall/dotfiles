#!/usr/bin/env nix-shell
#!nix-shell --quiet -i zsh -p nh -p gh

# Function to get the current generation
get_gen() {
    sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | awk '/current/ {print $1}'
}

# Get branch name
branch=$(git branch --show-current)

case "$branch" in
main)
    # Merge dev into main
    git merge dev --ff-only

    # If merge fails, exit
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

    # Create tag
    new_gen=$(get_gen)
    git tag -f "$(hostname) ($new_gen)" -m "NixOS configuration for generation $new_gen"
    git push -fq --tags

    # Push changes
    git push -q

    # Delete the dev branch
    git branch -D dev
    gh repo delete-branch dev

    # Recreate the dev branch
    git checkout -b dev
    git push -u origin dev
    ;;
dev)
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
    nh os test .

    # If nixos-rebuild fails, undo the commit and exit
    if [ $? -ne 0 ]; then
        git reset -q HEAD~
        exit 1
    fi

    # Push changes
    git push -q
    ;;
*)
    echo "ERROR: Unknown branch!"
    exit 1
    ;;
esac

exit 0
