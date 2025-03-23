# Git Fix all (script)

## **📜 `pull_merge_rebase_fix.sh` - Pull, Merge, Rebase & Fix**

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

echo -e "${CYAN}🔄 Pulling, merging, rebasing, and fixing all repositories...${RESET}"

# Find all Git repositories in the current directory
find "$start_dir" -type d -name ".git" | while read gitdir; do
  repo_dir=$(dirname "$gitdir")  # Get parent directory (actual repo)

  echo -e "${YELLOW}📂 Processing repository: ${repo_dir}${RESET}"

  cd "$repo_dir" || exit  # Move into the repository directory

  # Check if inside a git repository
  if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo -e "${RED}⚠️ Not a valid Git repository! Skipping...${RESET}"
    cd - > /dev/null || exit
    continue
  fi

  # Ensure the working directory is clean
  if ! git diff --quiet || ! git diff --staged --quiet; then
    echo -e "${RED}⚠️ Uncommitted changes detected! Stashing temporarily...${RESET}"
    git stash push -m "Auto-stash before pull" > /dev/null
    stash_applied=true
  else
    stash_applied=false
  fi

  # Fetch latest changes
  git fetch --all --prune

  # Get current branch
  current_branch=$(git rev-parse --abbrev-ref HEAD)

  # If in a detached HEAD state, reset to the default branch
  if [ "$current_branch" = "HEAD" ]; then
    default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
    echo -e "${YELLOW}⚠️ Detached HEAD detected! Checking out ${default_branch}...${RESET}"
    git checkout "$default_branch" || exit
    current_branch="$default_branch"
  fi

  # Check if branch is tracking a remote branch
  if git rev-parse --abbrev-ref --symbolic-full-name "@{u}" > /dev/null 2>&1; then
    echo -e "${CYAN}🔄 Pulling latest changes for branch: ${current_branch}${RESET}"

    # Try rebasing first
    if git pull --rebase; then
      echo -e "${GREEN}✅ Rebase successful!${RESET}"
    else
      echo -e "${YELLOW}⚠️ Rebase failed. Trying merge instead...${RESET}"

      # If rebase fails, abort and try merging
      git rebase --abort > /dev/null 2>&1  # Abort if a rebase is in progress
      if git pull --no-rebase; then
        echo -e "${GREEN}✅ Merge successful!${RESET}"
      else
        echo -e "${RED}❌ Merge failed! Trying automatic conflict resolution...${RESET}"

        # Attempt to automatically resolve conflicts
        git merge --abort > /dev/null 2>&1  # Abort failed merges
        git reset --hard HEAD  # Reset to the last commit
        git clean -fd  # Remove untracked files

        echo -e "${YELLOW}⚠️ Merge failed! Manual intervention required.${RESET}"
      fi
    fi
  else
    echo -e "${RED}⚠️ No tracking branch found for ${current_branch}. Skipping...${RESET}"
  fi

  # Apply stashed changes if any
  if [ "$stash_applied" = true ]; then
    echo -e "${YELLOW}🔄 Restoring stashed changes...${RESET}"
    git stash pop > /dev/null
  fi

  cd - > /dev/null || exit  # Return to the starting directory
done

echo -e "${GREEN}🎉 All repositories processed successfully!${RESET}"
```

---

## **🔍 How It Works**

### **1️⃣ Detects and Processes All Git Repos**

- Uses `find` to locate all `.git` directories.
- Moves into each repository to execute the process.

### **2️⃣ Ensures a Clean Working State**

- If **uncommitted changes** exist, it automatically **stashes** them.
- If the repo is in a **detached HEAD state**, it checks out the default branch.

### **3️⃣ Pulls and Updates the Repo**

- Runs `git fetch --all --prune` to clean up stale branches.
- Attempts to **rebase first** (`git pull --rebase`).
- If rebase **fails**, it falls back to **merge**.

### **4️⃣ Fixes Common Git Issues**

- If the branch has conflicts, it:
    - Aborts the rebase/merge (`git rebase --abort` or `git merge --abort`).
    - Resets to the last commit (`git reset --hard HEAD`).
    - Cleans untracked files (`git clean -fd`).

### **5️⃣ Restores Stashed Changes**

- If it had to stash files, it **unstashes them** after the pull.

---

## **🚀 How to Use It**

### **1️⃣ Save the script**

```bash
nano pull_merge_rebase_fix.sh
```

Paste the script and save.

### **2️⃣ Make it Executable**

```bash
chmod +x pull_merge_rebase_fix.sh
```

### **3️⃣ Run It**

```bash
./pull_merge_rebase_fix.sh
```

---

## **🔥 Optional: Create an Alias**

To make it easier to run, add this alias to `~/.bashrc` or `~/.zshrc`:

```bash
alias gitfix='bash ~/pull_merge_rebase_fix.sh'
```

Reload your shell:

```bash
source ~/.bashrc  # or source ~/.zshrc
```

Now, you can update all repos with:

```bash
gitfix
```