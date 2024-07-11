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
    # Create pr
    pr_url=$(gh pr create --base main --head dev --title "dev -> main" --body "Automated PR to merge dev into main")

    # If pr fails, then exit
    if [ $? -ne 0 ]; then
        exit 1
    fi

    # Run nixos-rebuild in pr branch
    pr=$(basename "$pr_url")
    gh pr checkout "$pr" >/dev/null 2>&1
    nh os switch .

    # If nixos-rebuild fails, delete the pr and exit
    if [ $? -ne 0 ]; then
        gh pr close "$pr"
        git checkout -q main
        exit 1
    fi

    # Merge pr and delete dev branch
    gh pr merge "$pr" --auto --squash --delete-branch --subject "dev -> main"

    # Create tag
    new_gen=$(get_gen)
    git tag -f "$(hostname)@$new_gen" -m "NixOS configuration for generation $new_gen"
    git push -qf --tags

    # Recreate the dev branch
    git checkout -q dev
    git push --no-verify -qu origin dev
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
