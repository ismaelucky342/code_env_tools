#!/bin/bash

# Show errors and commands
set -e

echo "🔍 Searching for submodules in .gitmodules..."
if [ ! -f .gitmodules ]; then
	echo "❌ .gitmodules not found. No submodules."
	exit 1
fi

# Initialize and update submodules if not already done
echo "📦 Initializing submodules..."
git submodule init
git submodule update

# Iterate over all defined submodules
echo "🔄 Updating each submodule..."
git config --file .gitmodules --get-regexp path | while read -r key path; do
	echo "📁 Entering submodule: $path"
	(
		cd "$path"
		echo "⬇️  Pulling submodule in $(pwd)..."
		git pull origin main 2>/dev/null || git pull origin master || echo "⚠️  Pull failed in $path"
	)
done

echo "✅ Submodules updated locally."

# Add submodule changes (updated references) to the main repo
echo "➕ Adding submodule changes to the main repo..."
git add .

echo "✅ Done. Now you can commit if you want to save the changes:"
echo "   git commit -m \"Update submodules\""
