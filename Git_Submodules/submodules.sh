#!/bin/bash

# Show errors and commands
set -e

echo "🔍 Searching for submodules in .gitmodules..."
if [ ! -f .gitmodules ]; then
	echo "❌ .gitmodules not found. No submodules."
	exit 1
fi

# Initialize submodules if not already done
echo "📦 Initializing submodules..."
git submodule init

# First, update submodules to match the commit referenced in the main repo
echo "🔄 Updating submodules to referenced commits..."
git submodule update

# Now update each submodule to the latest commit on their default branch
echo "🚀 Updating submodules to latest remote commits..."
git submodule foreach '
	echo "� Updating submodule: $name"
	
	# Fetch latest changes from remote
	echo "🔄 Fetching from remote..."
	git fetch origin
	
	# Determine the default branch (main or master)
	default_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed "s@^refs/remotes/origin/@@" || echo "main")
	
	# If default_branch detection failed, try main first, then master
	if ! git show-ref --verify --quiet "refs/remotes/origin/$default_branch"; then
		if git show-ref --verify --quiet "refs/remotes/origin/main"; then
			default_branch="main"
		elif git show-ref --verify --quiet "refs/remotes/origin/master"; then
			default_branch="master"
		else
			echo "⚠️  Could not determine default branch for $name"
			exit 1
		fi
	fi
	
	echo "📌 Default branch detected: $default_branch"
	
	# Checkout and pull the latest from the default branch
	echo "⬇️  Checking out and pulling latest $default_branch..."
	git checkout "$default_branch" || git checkout -b "$default_branch" "origin/$default_branch"
	git pull origin "$default_branch"
	
	echo "✅ $name updated to latest $default_branch"
'

echo "✅ All submodules updated to latest commits."

# Add submodule changes (updated references) to the main repo
echo "➕ Adding submodule changes to the main repo..."
git add .

# Show what changed
echo "📊 Changes made:"
git status --porcelain | grep -E "^M " || echo "No submodule changes detected"

echo "✅ Done! Submodules updated to latest versions."
echo "💡 To save these changes, run:"
echo "   git commit -m \"Update submodules to latest versions\""
echo "   git push"
