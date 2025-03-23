#!/bin/bash

# Verify if we're inside a Git repository
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "❌ Not inside a Git repository."
    exit 1
fi

# Function to handle Ctrl+C (SIGINT)
trap "echo -e '\n👋 Exiting...'; exit 0" SIGINT

while true; do
    clear
    echo "📜 Git Commit Tree (type 'exit' to quit):"

    git log --graph \
            --all \
            --color \
            --pretty=format:'%C(yellow)%h%C(reset) -%C(cyan)%d%C(reset) %s %C(blue)(%cr) %C(green)<%an>%C(reset)' \
            --abbrev-commit

    echo -e "\n🔹 Type 'exit' to quit."
    read -r input
    [[ "$input" == "exit" ]] && break
done

