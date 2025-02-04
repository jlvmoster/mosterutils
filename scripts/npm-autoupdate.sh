#!/bin/bash

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "jq could not be found, please install it to proceed."
    exit -1
fi

# Check for dry run flag
DRY_RUN=false
for arg in "$@"; do
    if [ "$arg" == "--dry-run" ]; then
        DRY_RUN=true
        echo "Dry-run mode: listing upcoming updates..."
        break
    fi
done

# Get the list of outdated packages in JSON format
outdated=$(npm outdated --json)

# Check if there are any outdated packages
if [ -z "$outdated" ]; then
    echo "All packages are up to date."
    exit 0
fi

# Loop through each outdated package and update it
echo "$outdated" | jq -r 'to_entries[] | "\(.key) \(.value.wanted)"' | while read pkg version; do
    if [ "$DRY_RUN" = true ]; then
        echo "[DRY-RUN] Would update $pkg to version $version"
    else
        echo "Updating $pkg to version $version"
        npm install "$pkg@$version"
    fi
done

if [ "$DRY_RUN" = false ]; then
    echo "All outdated packages have been updated."
else
    echo "Dry run complete. No packages were actually updated."
fi
