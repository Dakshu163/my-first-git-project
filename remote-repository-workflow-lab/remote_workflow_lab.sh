#!/bin/bash

echo "=== Part 1: Add and Inspect a Remote ==="
# Q.1 - Create a local repository and a bare remote
LAB_DIR="$HOME/git_prework/l4_q1"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/local_project"
cd "$LAB_DIR/local_project" && git init -b main >/dev/null
cd "$LAB_DIR" && git init --bare --initial-branch=main remote_project.git >/dev/null
echo "Local repository:" && ls -la "$LAB_DIR/local_project"
echo "Bare remote:" && ls -la "$LAB_DIR/remote_project.git"

# Q.2 - Add a remote named origin
LAB_DIR="$HOME/git_prework/l4_q2"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/local_project"
cd "$LAB_DIR/local_project"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "# Remote Practice\n" > README.md
git add README.md && git commit -m "Add README" >/dev/null
cd "$LAB_DIR" && git init --bare --initial-branch=main remote_project.git >/dev/null
cd "$LAB_DIR/local_project"
git remote add origin "$LAB_DIR/remote_project.git"
git remote -v

# Q.3 - Read a remote URL
LAB_DIR="$HOME/git_prework/l4_q3"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/local_project"
cd "$LAB_DIR/local_project" && git init -b main >/dev/null
cd "$LAB_DIR" && git init --bare --initial-branch=main remote_project.git >/dev/null
cd "$LAB_DIR/local_project"
git remote add origin "$LAB_DIR/remote_project.git"
git remote get-url origin

echo "=== Part 2: Push and Clone ==="
# Q.5 - Push main to a remote
LAB_DIR="$HOME/git_prework/l4_q5"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/local_project"
cd "$LAB_DIR/local_project"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "# Push Practice\n" > README.md
git add README.md && git commit -m "Add README" >/dev/null
cd "$LAB_DIR" && git init --bare --initial-branch=main remote_project.git >/dev/null
cd "$LAB_DIR/local_project"
git remote add origin "$LAB_DIR/remote_project.git"
git push -u origin main 2>&1

# Q.6 - Verify the remote branch
LAB_DIR="$HOME/git_prework/l4_q6"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/local_project"
cd "$LAB_DIR/local_project"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "hello remote\n" > file.txt
git add file.txt && git commit -m "Add file" >/dev/null
cd "$LAB_DIR" && git init --bare --initial-branch=main remote_project.git >/dev/null
cd "$LAB_DIR/local_project"
git remote add origin "$LAB_DIR/remote_project.git"
git push -u origin main >/dev/null 2>&1
git --git-dir="$LAB_DIR/remote_project.git" show-ref

# Q.7 - Clone a remote repository
LAB_DIR="$HOME/git_prework/l4_q7"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/source"
cd "$LAB_DIR/source"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "# Clone Practice\n" > README.md
git add README.md && git commit -m "Add README" >/dev/null
cd "$LAB_DIR" && git init --bare --initial-branch=main remote_project.git >/dev/null
cd "$LAB_DIR/source"
git remote add origin "$LAB_DIR/remote_project.git"
git push -u origin main >/dev/null 2>&1
cd "$LAB_DIR"
git clone "$LAB_DIR/remote_project.git" cloned_project >/dev/null 2>&1
cd "$LAB_DIR/cloned_project"
cat README.md
git log --oneline

echo "=== Part 3: Fetch and Pull ==="
# Q.9 - Fetch a new remote commit without updating working file
LAB_DIR="$HOME/git_prework/l4_q9"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/source"
cd "$LAB_DIR/source"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "version 1\n" > notes.txt
git add notes.txt && git commit -m "Add notes" >/dev/null
cd "$LAB_DIR" && git init --bare --initial-branch=main remote_project.git >/dev/null
cd "$LAB_DIR/source"
git remote add origin "$LAB_DIR/remote_project.git"
git push -u origin main >/dev/null 2>&1
cd "$LAB_DIR" && git clone "$LAB_DIR/remote_project.git" second_copy >/dev/null 2>&1
cd "$LAB_DIR/second_copy"
git config user.name "Second Student" && git config user.email "second@example.com"
printf "version 2\n" >> notes.txt
git add notes.txt && git commit -m "Update notes" >/dev/null
git push origin main >/dev/null 2>&1
cd "$LAB_DIR/source"
echo "Before fetch:" && cat notes.txt
git fetch origin >/dev/null 2>&1
echo "After fetch, working file is still:" && cat notes.txt
echo "Remote history:" && git log --oneline origin/main -n 2

# Q.10 - Pull a remote update
LAB_DIR="$HOME/git_prework/l4_q10"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/source"
cd "$LAB_DIR/source"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "version 1\n" > notes.txt
git add notes.txt && git commit -m "Add notes" >/dev/null
cd "$LAB_DIR" && git init --bare --initial-branch=main remote_project.git >/dev/null
cd "$LAB_DIR/source"
git remote add origin "$LAB_DIR/remote_project.git"
git push -u origin main >/dev/null 2>&1
cd "$LAB_DIR" && git clone "$LAB_DIR/remote_project.git" second_copy >/dev/null 2>&1
cd "$LAB_DIR/second_copy"
git config user.name "Second Student" && git config user.email "second@example.com"
printf "version 2\n" >> notes.txt
git add notes.txt && git commit -m "Update notes" >/dev/null
git push origin main >/dev/null 2>&1
cd "$LAB_DIR/source"
git pull --ff-only >/dev/null 2>&1
cat notes.txt

# Q.11 - Compare local main with origin/main
LAB_DIR="$HOME/git_prework/l4_q11"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/local_project"
cd "$LAB_DIR/local_project"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "one\n" > notes.txt
git add notes.txt && git commit -m "Add first note" >/dev/null
cd "$LAB_DIR" && git init --bare --initial-branch=main remote_project.git >/dev/null
cd "$LAB_DIR/local_project"
git remote add origin "$LAB_DIR/remote_project.git"
git push -u origin main >/dev/null 2>&1
printf "two\n" >> notes.txt
git add notes.txt && git commit -m "Add second note" >/dev/null
git status --short --branch
git log --oneline --decorate --graph -n 3

echo "=== Part 4: Remote Maintenance and Verification ==="
# Q.13 - Change a remote URL
LAB_DIR="$HOME/git_prework/l4_q13"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/local_project"
cd "$LAB_DIR/local_project" && git init -b main >/dev/null
cd "$LAB_DIR" && git init --bare remote_one.git >/dev/null && git init --bare remote_two.git >/dev/null
cd "$LAB_DIR/local_project"
git remote add origin "$LAB_DIR/remote_one.git"
git remote get-url origin
git remote set-url origin "$LAB_DIR/remote_two.git"
git remote get-url origin

# Q.14 - Remove and re-add a remote
LAB_DIR="$HOME/git_prework/l4_q14"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/local_project"
cd "$LAB_DIR/local_project" && git init -b main >/dev/null
cd "$LAB_DIR" && git init --bare --initial-branch=main remote_project.git >/dev/null
cd "$LAB_DIR/local_project"
git remote add origin "$LAB_DIR/remote_project.git"
git remote -v
git remote remove origin
echo "After removal:" && git remote -v
git remote add origin "$LAB_DIR/remote_project.git"
echo "After adding again:" && git remote -v

# Q.15 - Check whether local and remote point to the same commit
LAB_DIR="$HOME/git_prework/l4_q15"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/local_project"
cd "$LAB_DIR/local_project"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "check\n" > file.txt
git add file.txt && git commit -m "Add file" >/dev/null
cd "$LAB_DIR" && git init --bare --initial-branch=main remote_project.git >/dev/null
cd "$LAB_DIR/local_project"
git remote add origin "$LAB_DIR/remote_project.git"
git push -u origin main >/dev/null 2>&1
echo "Local main:" && git rev-parse main
echo "Remote-tracking main:" && git rev-parse origin/main

echo "=== Optional Practice (Q.17 - Q.20) ==="
# Q.17 - Diagnose an unconfigured remote
LAB_DIR="$HOME/git_prework/l4_q17"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/local_project"
cd "$LAB_DIR/local_project" && git init -b main >/dev/null
echo "Before:" && git remote -v
cd "$LAB_DIR" && git init --bare --initial-branch=main remote_project.git >/dev/null
cd "$LAB_DIR/local_project"
git remote add origin "$LAB_DIR/remote_project.git"
echo "After:" && git remote -v

# Q.18 - Detect an ahead local branch
LAB_DIR="$HOME/git_prework/l4_q18"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/local_project"
cd "$LAB_DIR/local_project"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "one\n" > notes.txt
git add notes.txt && git commit -m "Add first note" >/dev/null
cd "$LAB_DIR" && git init --bare --initial-branch=main remote_project.git >/dev/null
cd "$LAB_DIR/local_project"
git remote add origin "$LAB_DIR/remote_project.git"
git push -u origin main >/dev/null 2>&1
printf "two\n" >> notes.txt
git add notes.txt && git commit -m "Add second note" >/dev/null
git status --short --branch

# Q.19 - Detect a behind local branch
LAB_DIR="$HOME/git_prework/l4_q19"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/source"
cd "$LAB_DIR/source"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "one\n" > notes.txt
git add notes.txt && git commit -m "Add first note" >/dev/null
cd "$LAB_DIR" && git init --bare --initial-branch=main remote_project.git >/dev/null
cd "$LAB_DIR/source"
git remote add origin "$LAB_DIR/remote_project.git"
git push -u origin main >/dev/null 2>&1
cd "$LAB_DIR" && git clone "$LAB_DIR/remote_project.git" second_copy >/dev/null 2>&1
cd "$LAB_DIR/second_copy"
git config user.name "Second Student" && git config user.email "second@example.com"
printf "two\n" >> notes.txt
git add notes.txt && git commit -m "Add second note" >/dev/null
git push origin main >/dev/null 2>&1
cd "$LAB_DIR/source"
git fetch origin >/dev/null 2>&1
git status --short --branch

# Q.20 - Complete a main-branch remote workflow
LAB_DIR="$HOME/git_prework/l4_q20"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/original"
cd "$LAB_DIR/original"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "# Project\n" > README.md
printf "batch_size=100\n" > settings.txt
git add README.md settings.txt && git commit -m "Add project files" >/dev/null
cd "$LAB_DIR" && git init --bare --initial-branch=main remote_project.git >/dev/null
cd "$LAB_DIR/original"
git remote add origin "$LAB_DIR/remote_project.git"
git push -u origin main >/dev/null 2>&1
cd "$LAB_DIR" && git clone "$LAB_DIR/remote_project.git" second_copy >/dev/null 2>&1
cd "$LAB_DIR/second_copy"
git config user.name "Second Student" && git config user.email "second@example.com"
printf "batch_size=500\n" > settings.txt
git add settings.txt && git commit -m "Increase batch size" >/dev/null
git push origin main >/dev/null 2>&1
cd "$LAB_DIR/original"
git pull --ff-only >/dev/null 2>&1
cat settings.txt
git log --oneline -n 3
