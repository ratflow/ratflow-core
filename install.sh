#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 [-f|--force] <config_directory>"
    exit 1
}

# Function to install dependencies
installDependencies() {
    local dependencies=()
    while IFS= read -r package; do
        dependencies+=("$package")
    done < "$1/dependencies"

    if [ ${#dependencies[@]} -gt 0 ]; then
        apt satisfy -y "${dependencies[@]}"
    fi
}

# Function to handle resource installation
installResource() {
    local src=$1
    local dst=$2

    # Check for existence of destination and FORCE_MODE not set
    if [ -e "$dst" ] && [ $FORCE_MODE -eq 0 ]; then
        if [ -d "$src" ]; then
            echo "Copying contents without replacing existing files: $dst"
            # Copy directory contents recursively without replacing existing files
            cp -rn "$src/"* "$dst"
        else
            echo "Skipping existing resource: $dst"
            echo "Note: use -f or --force to backup and replace"
        fi
        return
    fi

    # Handle force mode when destination exists
    if [ $FORCE_MODE -eq 1 ] && [ -e "$dst" ]; then
        local backupDir="/var/${PROJECT_NAME}-backups/$(date +%Y%m%d%H%M%S)/"
        mkdir -p "$backupDir$(dirname "$dst")"
        mv "$dst" "$backupDir$dst"
        echo "Backed up $dst to $backupDir"
    fi

    # Ensure destination directory exists
    mkdir -p "$(dirname "$dst")"

    # Copy the source to destination
    if [ -d "$src" ]; then
        # Copy all contents recursively with replacement when FORCE_MODE is 1
        cp -ra "$src/"* "$dst"
    else
        # This will copy files with replacement when FORCE_MODE is 1
        cp -rv "$src" "$dst"
    fi
}


# Function to run scripts in a directory
runScripts() {
    local dir=$1
    for script in "$dir"/*.sh; do
        [ -e "$script" ] || continue
        bash "$script"
    done
}

# Check for at least one argument
if [ $# -lt 1 ]; then
    usage
fi

# Parse arguments
FORCE_MODE=0
CONFIG_DIR=""

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -f|--force) FORCE_MODE=1 ;;
        *) CONFIG_DIR="$1" ;;
    esac
    shift
done

if [[ -z "$CONFIG_DIR" ]]; then
    usage
fi

# Source the project configuration
source "$CONFIG_DIR/config" || { echo "Failed to source config file"; exit 1; }

# Install dependencies
installDependencies "$CONFIG_DIR"

# Install resources
while IFS= read -r line; do
    eval "installResource $line"
done < "$CONFIG_DIR/resources"

# Run pre-installation scripts
runScripts "$CONFIG_DIR/preinst.d"

# Run post-installation scripts
runScripts "$CONFIG_DIR/postinst.d"

echo "Installation completed."
