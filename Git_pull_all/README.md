# General git Pull (script)

### **📜 `pull_all.sh`: Automatically Pull Updates for All Git Repositories**

```bash

#!/bin/bash

GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
RED="\e[31m"
RESET="\e[0m"

start_dir=$(pwd)

echo -e "${CYAN}🔄 Fixing and pulling latest changes from all repositories...${RESET}"

find "$start_dir" -type d -name ".git" | while read gitdir; do
  repo_dir=$(dirname "$gitdir")
  echo -e "${YELLOW}📂 Processing repository: ${repo_dir}${RESET}"

  cd "$repo_dir" || exit

  if [ -f .git/ORIG_HEAD ]; then
    rm -f .git/ORIG_HEAD
    echo -e "${CYAN}🛠 Fixed ORIG_HEAD${RESET}"
  fi

  if git pull; then
    echo -e "${GREEN}✅ Pulled successfully!${RESET}"
  else
    echo -e "${RED}❌ Pull failed!${RESET}"
  fi

  cd - > /dev/null || exit
done

echo -e "${GREEN}🎉 All repositories are up to date!${RESET}"
```

---

### **🔍 How the Script Works**

1. **Defines color-coded messages**
    - Green ✅ → Success messages
    - Yellow 📂 → Processing messages
    - Cyan 🔄 → General info
    - Red ❌ → Errors
2. **Stores the current directory (`start_dir`)**
    - Ensures the script returns to the original directory after processing each repo.
3. **Finds all Git repositories in the current folder**
    - `find "$start_dir" -type d -name ".git"` looks for `.git` directories, indicating a Git repository.
4. **Loops through each repository found**
    - Extracts the repo folder.
    - Displays which repository is being processed.
5. **Performs Git operations in each repository**
    - **`git pull`** → Fetches and merges the latest changes from the remote repository.
        - If successful, it prints `"✅ Pull successful!"`.
        - If it fails, it prints `"❌ Pull failed!"`.
6. **Returns to the starting directory (`cd - > /dev/null`)**
    - This prevents the script from getting stuck inside subdirectories.
    - The `> /dev/null` part suppresses unnecessary output.
7. **Prints a final success message 🎉**
    - `"All repositories are up to date!"`

---

### **🚀 What This Script Does**

✔ **Automatically finds all Git repositories in the current directory**

✔ **Pulls the latest updates from each repository**

✔ **Handles errors (e.g., pull failures)**

✔ **Uses colors to clearly show progress and issues**

---

### **🔥 How to Use It**

1. **Save the script as `pull_all.sh`**
2. **Make it executable**
    
    ```bash
    chmod +x pull_all.sh
    ```
    
3. **Run the script**
    
    ```bash
    ./pull_all.sh
    ```
    

---

### **💡 Extra: Create a Bash Alias**

To run this command easily, add this alias to `~/.bashrc` or `~/.zshrc`:

```bash
alias pullall="~/path/to/pull_all.sh"
```

Then, reload your shell:

```bash
source ~/.bashrc  # or source ~/.zshrc
```

Now, you can **pull all repos** just by typing:

```bash
pullall
```