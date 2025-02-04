#!/bin/bash

# Create the .local/bin directory if it doesn't exist
mkdir -p "$HOME/.local/bin"

# Copy the npm-autoupdate.sh script to .local/bin
cp ./scripts/npm-autoupdate.sh "$HOME/.local/bin/"

# Make the script executable
chmod +x "$HOME/.local/bin/npm-autoupdate.sh"

echo "npm-autoupdate.sh has been installed to $HOME/.local/bin and is now executable."
