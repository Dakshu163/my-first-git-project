#!/bin/bash

echo "=== Part 1: Create and Switch Branches ==="
# Q.1 - Create a feature branch
LAB_DIR="$HOME/git_prework/l5_q1"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "# Project\n" > README.md
git add README.md && git commit -m "Add README" >/dev/null
git branch feature/add-notes
git branch

# Q.2 - Switch to a branch
LAB_DIR="$HOME/git_prework/l5_q2"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "base\n" > file.txt
git add file.txt && git commit -m "Add base file" >/dev/null
git branch feature/settings
git switch feature/settings >/dev/null 2>&1
git branch --show-current

# Q.3 - Create and switch in one command
LAB_DIR="$HOME/git_prework/l5_q3"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "start\n" > notes.txt
git add notes.txt && git commit -m "Add notes" >/dev/null
git switch -c feature/docs >/dev/null 2>&1
git branch --show-current

echo "=== Part 2: Commit and Merge Feature Work ==="
# Q.5 - Commit only on a feature branch
LAB_DIR="$HOME/git_prework/l5_q5"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "base\n" > base.txt
git add base.txt && git commit -m "Add base file" >/dev/null
git switch -c feature/new-file >/dev/null 2>&1
printf "feature work\n" > feature.txt
git add feature.txt && git commit -m "Add feature file" >/dev/null
git switch main >/dev/null 2>&1
ls -la

# Q.6 - Merge a simple feature
LAB_DIR="$HOME/git_prework/l5_q6"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "base\n" > base.txt
git add base.txt && git commit -m "Add base" >/dev/null
git switch -c feature/report >/dev/null 2>&1
printf "report notes\n" > report.txt
git add report.txt && git commit -m "Add report notes" >/dev/null
git switch main >/dev/null 2>&1
git merge feature/report >/dev/null 2>&1
ls -la
git log --oneline --graph --decorate --all

# Q.7 - Create an explicit merge commit (--no-ff)
LAB_DIR="$HOME/git_prework/l5_q7"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "base\n" > file.txt
git add file.txt && git commit -m "Add base" >/dev/null
git switch -c feature/update >/dev/null 2>&1
printf "feature line\n" >> file.txt
git add file.txt && git commit -m "Add feature line" >/dev/null
git switch main >/dev/null 2>&1
git merge --no-ff feature/update -m "Merge feature/update" >/dev/null 2>&1
git log --oneline --graph --decorate --all

echo "=== Part 3: Understand and Resolve Conflicts ==="
# Q.9 - Create a simple merge conflict
LAB_DIR="$HOME/git_prework/l5_q9"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "mode=base\n" > settings.txt
git add settings.txt && git commit -m "Add base setting" >/dev/null
git switch -c feature/mode >/dev/null 2>&1
printf "mode=feature\n" > settings.txt
git add settings.txt && git commit -m "Change mode on feature" >/dev/null
git switch main >/dev/null 2>&1
printf "mode=main\n" > settings.txt
git add settings.txt && git commit -m "Change mode on main" >/dev/null
git merge feature/mode >/dev/null 2>&1 || true
git status --short
cat settings.txt

# Q.10 - Read conflict markers
LAB_DIR="$HOME/git_prework/l5_q10"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "value=base\n" > config.txt
git add config.txt && git commit -m "Add config" >/dev/null
git switch -c feature/config >/dev/null 2>&1
printf "value=feature\n" > config.txt
git add config.txt && git commit -m "Feature config" >/dev/null
git switch main >/dev/null 2>&1
printf "value=main\n" > config.txt
git add config.txt && git commit -m "Main config" >/dev/null
git merge feature/config >/dev/null 2>&1 || true
cat config.txt

# Q.11 - Resolve a conflict by choosing a final value
LAB_DIR="$HOME/git_prework/l5_q11"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "batch_size=100\n" > settings.txt
git add settings.txt && git commit -m "Add base batch size" >/dev/null
git switch -c feature/batch >/dev/null 2>&1
printf "batch_size=500\n" > settings.txt
git add settings.txt && git commit -m "Increase batch size on feature" >/dev/null
git switch main >/dev/null 2>&1
printf "batch_size=250\n" > settings.txt
git add settings.txt && git commit -m "Change batch size on main" >/dev/null
git merge feature/batch >/dev/null 2>&1 || true
printf "batch_size=500\n" > settings.txt
git add settings.txt
git commit -m "Resolve batch-size merge conflict" >/dev/null
cat settings.txt
git status --short
git log --oneline --graph --all -n 6

echo "=== Part 4: Collaborate Through a Shared Remote ==="
# Q.13 - Push a feature branch
LAB_DIR="$HOME/git_prework/l5_q13"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/original" && cd "$LAB_DIR/original"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "# Project\n" > README.md
git add README.md && git commit -m "Add README" >/dev/null
cd "$LAB_DIR" && git init --bare --initial-branch=main remote.git >/dev/null
cd "$LAB_DIR/original"
git remote add origin "$LAB_DIR/remote.git"
git push -u origin main >/dev/null 2>&1
git switch -c feature/docs >/dev/null 2>&1
printf "Documentation update\n" > docs.txt
git add docs.txt && git commit -m "Add documentation" >/dev/null
git push -u origin feature/docs >/dev/null 2>&1
git branch -avv

# Q.14 - Clone and inspect a remote feature branch
LAB_DIR="$HOME/git_prework/l5_q14"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/original" && cd "$LAB_DIR/original"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "base\n" > file.txt
git add file.txt && git commit -m "Add base" >/dev/null
cd "$LAB_DIR" && git init --bare --initial-branch=main remote.git >/dev/null
cd "$LAB_DIR/original"
git remote add origin "$LAB_DIR/remote.git"
git push -u origin main >/dev/null 2>&1
git switch -c feature/report >/dev/null 2>&1
printf "report\n" > report.txt
git add report.txt && git commit -m "Add report" >/dev/null
git push -u origin feature/report >/dev/null 2>&1
cd "$LAB_DIR" && git clone "$LAB_DIR/remote.git" collaborator >/dev/null 2>&1
cd "$LAB_DIR/collaborator"
git fetch origin >/dev/null 2>&1
git branch -r

# Q.15 - Review branch differences before merge
LAB_DIR="$HOME/git_prework/l5_q15"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "base\n" > base.txt
git add base.txt && git commit -m "Add base" >/dev/null
git switch -c feature/report >/dev/null 2>&1
printf "report\n" > report.txt
git add report.txt && git commit -m "Add report" >/dev/null
git diff main..feature/report --name-status

echo "=== Optional Practice (Q.17 - Q.20) ==="
# Q.17 - Delete a merged local branch
LAB_DIR="$HOME/git_prework/l5_q17"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "base\n" > base.txt
git add base.txt && git commit -m "Add base" >/dev/null
git switch -c feature/cleanup >/dev/null 2>&1
printf "cleanup notes\n" > cleanup.txt
git add cleanup.txt && git commit -m "Add cleanup notes" >/dev/null
git switch main >/dev/null 2>&1
git merge feature/cleanup >/dev/null 2>&1
git branch -d feature/cleanup >/dev/null
git branch

# Q.18 - Stop a merge before resolving it (git merge --abort)
LAB_DIR="$HOME/git_prework/l5_q18"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR" && cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "value=base\n" > config.txt
git add config.txt && git commit -m "Add config" >/dev/null
git switch -c feature/config >/dev/null 2>&1
printf "value=feature\n" > config.txt
git add config.txt && git commit -m "Feature change" >/dev/null
git switch main >/dev/null 2>&1
printf "value=main\n" > config.txt
git add config.txt && git commit -m "Main change" >/dev/null
git merge feature/config >/dev/null 2>&1 || true
git status --short
git merge --abort
git status --short
cat config.txt

# Q.19 - Simulate a two-person feature update
LAB_DIR="$HOME/git_prework/l5_q19"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/original" && cd "$LAB_DIR/original"
git init -b main >/dev/null
git config user.name "First Student" && git config user.email "first@example.com"
printf "base\n" > file.txt
git add file.txt && git commit -m "Add base" >/dev/null
cd "$LAB_DIR" && git init --bare --initial-branch=main remote.git >/dev/null
cd "$LAB_DIR/original"
git remote add origin "$LAB_DIR/remote.git"
git push -u origin main >/dev/null 2>&1
git switch -c feature/shared >/dev/null 2>&1
printf "first change\n" > shared.txt
git add shared.txt && git commit -m "Start shared feature" >/dev/null
git push -u origin feature/shared >/dev/null 2>&1
cd "$LAB_DIR" && git clone "$LAB_DIR/remote.git" second_copy >/dev/null 2>&1
cd "$LAB_DIR/second_copy"
git config user.name "Second Student" && git config user.email "second@example.com"
git switch -c feature/shared --track origin/feature/shared >/dev/null 2>&1
printf "second change\n" >> shared.txt
git add shared.txt && git commit -m "Continue shared feature" >/dev/null
git push origin feature/shared >/dev/null 2>&1
cd "$LAB_DIR/original"
git fetch origin >/dev/null 2>&1
git log --oneline feature/shared..origin/feature/shared

# Q.20 - Complete a feature collaboration workflow
LAB_DIR="$HOME/git_prework/l5_q20"
rm -rf "$LAB_DIR" && mkdir -p "$LAB_DIR/original" && cd "$LAB_DIR/original"
git init -b main >/dev/null
git config user.name "First Student" && git config user.email "first@example.com"
printf "# Project\n" > README.md
git add README.md && git commit -m "Add project" >/dev/null
cd "$LAB_DIR" && git init --bare --initial-branch=main remote.git >/dev/null
cd "$LAB_DIR/original"
git remote add origin "$LAB_DIR/remote.git"
git push -u origin main >/dev/null 2>&1
git switch -c feature/settings >/dev/null 2>&1
printf "batch_size=100\n" > settings.txt
git add settings.txt && git commit -m "Add batch setting" >/dev/null
git push -u origin feature/settings >/dev/null 2>&1
cd "$LAB_DIR" && git clone "$LAB_DIR/remote.git" second_copy >/dev/null 2>&1
cd "$LAB_DIR/second_copy"
git config user.name "Second Student" && git config user.email "second@example.com"
git switch -c feature/settings --track origin/feature/settings >/dev/null 2>&1
printf "retries=3\n" >> settings.txt
git add settings.txt && git commit -m "Add retry setting" >/dev/null
git push origin feature/settings >/dev/null 2>&1
cd "$LAB_DIR/original"
git fetch origin >/dev/null 2>&1
git switch feature/settings >/dev/null 2>&1
git merge --ff-only origin/feature/settings >/dev/null 2>&1
git diff main..feature/settings
git switch main >/dev/null 2>&1
git merge --no-ff feature/settings -m "Merge feature/settings" >/dev/null 2>&1
git push origin main >/dev/null 2>&1
git log --oneline --graph --decorate --all -n 8
