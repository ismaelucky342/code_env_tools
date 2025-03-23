# General git Push (script)

### **📜 Push Script: Automate Git Add, Commit, and Push for All Repos**

```bash
#!/bin/bash

# Define colors for output
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
RED="\e[31m"
RESET="\e[0m"

# Store the current working directory
start_dir=$(pwd)

# Get the current date and time for the commit message
timestamp=$(date +"%d-%m-%Y %H:%M:%S")

echo -e "${CYAN}🔄 Updating and pushing all repositories...${RESET}"

# Find all subdirectories that contain a .git folder (indicating a Git repo)
find "$start_dir" -type d -name ".git" | while read gitdir; do
  repo_dir=$(dirname "$gitdir")  # Get the parent directory (actual repo)

  echo -e "${YELLOW}📂 Processing repository: ${repo_dir}${RESET}"

  cd "$repo_dir" || exit  # Change into the repository directory

  # Add all changes
  git add .

  # Commit changes with timestamp
  if git commit -m "Auto-commit: $timestamp"; then
    echo -e "${GREEN}✅ Committed successfully!${RESET}"
  else
    echo -e "${RED}⚠️ Nothing to commit.${RESET}"
  fi

  # Push to remote repository
  if git push; then
    echo -e "${GREEN}🚀 Pushed successfully!${RESET}"
  else
    echo -e "${RED}❌ Push failed!${RESET}"
  fi

  cd - > /dev/null || exit  # Return to the starting directory (suppress output)
done

echo -e "${GREEN}🎉 All repositories are up to date!${RESET}"nano
```

---

### **🔍 How the script works**

1. **Sets up color-coded messages**
    - Green ✅ → Success messages
    - Yellow 📂 → Processing messages
    - Cyan 🔄 → General info
    - Red ❌ → Errors
2. **Stores the current directory (`start_dir`)**
    - This ensures that after processing each repo, we can return to the original directory.
3. **Gets the current date & time for the commit message**
    - The format is `"DD-MM-YYYY HH:MM:SS"`
    - Example commit message:
        
        ```
        Commit: 23-03-2025 15:45:10
        ```
        
4. **Finds all Git repositories inside the current directory**
    - `find "$start_dir" -type d -name ".git"` looks for all `.git` folders (which means a Git repository is present).
5. **Loops through each repository found**
    - Extracts the parent folder of `.git`, which is the actual repo.
    - Prints the repository name.
6. **Performs Git operations in each repository**
    - **`git add .`** → Stages all changes.
    - **`git commit -m "Auto-commit: $timestamp"`** → Commits changes with a timestamp.
        - If nothing has changed, it prints `"⚠️ Nothing to commit"`.
    - **`git push`** → Pushes changes to the remote repo.
        - If it fails, it prints `"❌ Push failed!"`.
7. **Returns to the starting directory (`cd - > /dev/null`)**
    - This ensures the script does not get stuck in a subdirectory.
    - The `> /dev/null` part suppresses unnecessary output.
8. **Prints a final success message 🎉**
    - `"All repositories are up to date!"`

---

### **🚀 What This Script Does**

✔ **Automatically detects all Git repositories in the current folder**

✔ **Adds, commits, and pushes changes with a timestamp**

✔ **Handles errors (e.g., no changes, push failure)**

✔ **Uses colors to clearly show progress and issues**

### **🔥 How to Use It**

1. **Save the script as `push_all.sh`**
2. **Make it executable**
    
    ```bash
    chmod +x push_all.sh
    ```
    
3. **Run the script**
    
    ```bash
    ./push_all.sh
    ```
    

### **💡 Extra: Create a Bash Alias**

To run this command easily, add this alias to `~/.bashrc` or `~/.zshrc`:

```bash
alias pushall="~/path/to/pushall.sh"
```

Then, reload your shell:

```bash
source ~/.bashrc  # or source ~/.zshrc
```

Now, you can **push all repos** just by typing:

```bash
pushall
```