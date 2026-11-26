#!/bin/bash

echo "=== Part 1: Initialise and Inspect a Repository ==="
# Q.1 - Create a new local repository
LAB_DIR="$HOME/git_prework/l3_q1"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git status --short --branch

# Q.2 - Inspect an untracked file
LAB_DIR="$HOME/git_prework/l3_q2"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
printf "# Practice Project\n" > README.md
git status --short

# Q.3 - Stage one file
LAB_DIR="$HOME/git_prework/l3_q3"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
printf "# Project\n" > README.md
printf "local notes\n" > notes.txt
git add README.md
git status --short

echo "=== Part 2: Create and Review Commits ==="
# Q.5 - Make a first commit
LAB_DIR="$HOME/git_prework/l3_q5"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student"
git config user.email "student@example.com"
printf "# Orders Project\n" > README.md
git add README.md
git commit -m "Add project README" >/dev/null
git status --short

# Q.6 - View compact history
LAB_DIR="$HOME/git_prework/l3_q6"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student"
git config user.email "student@example.com"
printf "version 1\n" > notes.txt
git add notes.txt && git commit -m "Add notes" >/dev/null
printf "version 2\n" >> notes.txt
git add notes.txt && git commit -m "Update notes" >/dev/null
git log --oneline

# Q.7 - Inspect one commit
LAB_DIR="$HOME/git_prework/l3_q7"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student"
git config user.email "student@example.com"
printf "batch_size=100\n" > config.txt
git add config.txt && git commit -m "Add batch configuration" >/dev/null
git show --stat --oneline HEAD

echo "=== Part 3: Compare and Restore Changes ==="
# Q.9 - View an unstaged difference
LAB_DIR="$HOME/git_prework/l3_q9"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student"
git config user.email "student@example.com"
printf "batch_size=100\n" > settings.txt
git add settings.txt && git commit -m "Add settings" >/dev/null
printf "batch_size=500\n" > settings.txt
git diff

# Q.10 - Compare staged changes
LAB_DIR="$HOME/git_prework/l3_q10"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student"
git config user.email "student@example.com"
printf "retries=1\n" > settings.txt
git add settings.txt && git commit -m "Add retry setting" >/dev/null
printf "retries=3\n" > settings.txt
git add settings.txt
git diff --staged

# Q.11 - Discard an unstaged edit
LAB_DIR="$HOME/git_prework/l3_q11"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student"
git config user.email "student@example.com"
printf "environment=dev\n" > settings.txt
git add settings.txt && git commit -m "Add environment setting" >/dev/null
printf "environment=WRONG\n" > settings.txt
git restore settings.txt
cat settings.txt
git status --short

echo "=== Part 4: Unstage, Ignore, and Check State ==="
# Q.13 - Unstage a file without losing the edit
LAB_DIR="$HOME/git_prework/l3_q13"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student"
git config user.email "student@example.com"
printf "mode=basic\n" > settings.txt
git add settings.txt && git commit -m "Add settings" >/dev/null
printf "mode=extended\n" > settings.txt
git add settings.txt
echo "Before unstaging:"
git status --short
git restore --staged settings.txt
echo "After unstaging:"
git status --short
git diff

# Q.14 - Ignore a local secret file (.env)
LAB_DIR="$HOME/git_prework/l3_q14"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
printf "API_KEY=practice-only\n" > .env
printf "# Project\n" > README.md
printf ".env\n" > .gitignore
git status --short

# Q.15 - Ignore a data folder (data/raw/)
LAB_DIR="$HOME/git_prework/l3_q15"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/data/raw" "$LAB_DIR/data/sample" && cd "$LAB_DIR"
git init -b main >/dev/null
printf "1,100\n" > data/raw/orders.csv
printf "1,10\n" > data/sample/orders_sample.csv
printf "data/raw/\n" > .gitignore
git status --short

echo "=== Optional Practice (Q.17 - Q.20) ==="
# Q.17 - Stage only one of two changes
LAB_DIR="$HOME/git_prework/l3_q17"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student"
git config user.email "student@example.com"
printf "A1\n" > a.txt
printf "B1\n" > b.txt
git add a.txt b.txt && git commit -m "Add two files" >/dev/null
printf "A2\n" >> a.txt
printf "B2\n" >> b.txt
git add a.txt
git status --short

# Q.18 - Recover after staging the wrong file
LAB_DIR="$HOME/git_prework/l3_q18"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
printf "keep me staged\n" > keep.txt
printf "do not commit yet\n" > later.txt
git add keep.txt later.txt
git restore --staged later.txt
git status --short

# Q.19 - Compare working, staged, and committed states
LAB_DIR="$HOME/git_prework/l3_q19"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student"
git config user.email "student@example.com"
printf "value=1\n" > settings.txt
git add settings.txt && git commit -m "Add initial value" >/dev/null
printf "value=2\n" > settings.txt
git add settings.txt
printf "value=3\n" > settings.txt
git status --short
echo "Unstaged difference:"
git diff
echo "Staged difference:"
git diff --staged

# Q.20 - Complete a clean local workflow
LAB_DIR="$HOME/git_prework/l3_q20"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student"
git config user.email "student@example.com"
printf "# Local Workflow\n" > README.md
printf ".env\n" > .gitignore
printf "API_KEY=practice\n" > .env
git add README.md .gitignore && git commit -m "Add README and ignore rules" >/dev/null
printf "batch_size=100\n" > settings.txt
git add settings.txt && git commit -m "Add batch settings" >/dev/null
git log --oneline
git status --short
