#!/bin/bash

# Script to delete all cloned git repositories in all folders and subfolders

# Function to delete git repositories
delete_git_repos() {
    for dir in "$1"/*; do
        if [ -d "$dir" ]; then
            if [ -d "$dir/.git" ]; then
                echo "🗑️ Deleting git repository in $dir"
                rm -rf "$dir"
                echo "✅ Deleted $dir"
            else
                echo "📂 Entering directory $dir"
                delete_git_repos "$dir"
                echo "⬅️ Exiting directory $dir"
            fi
        fi
    done
}

# Start from the current directory
echo "🚀 Starting to delete git repositories from $(pwd)"
delete_git_repos "$(pwd)"
echo "🏁 Finished deleting git repositories"