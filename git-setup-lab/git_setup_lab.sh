#!/bin/bash

# Save existing user identity if already configured
ORIG_NAME=$(git config --global --get user.name || true)
ORIG_EMAIL=$(git config --global --get user.email || true)

echo "=== Part 1: Verify Git ==="
# Q.1 & Q.2
git --version
command -v git

echo "=== Part 2: Configure Identity ==="
# Q.5, Q.6, Q.7
git config --global user.name "Practice Student"
git config --global --get user.name
git config --global user.email "student@example.com"
git config --global --get user.email

echo "=== Part 3: Inspect Useful Git Settings ==="
# Q.9, Q.10, Q.11
git config --global init.defaultBranch main
git config --global --get init.defaultBranch
git config --global --show-origin --list

echo "=== Part 4: Prepare SSH Authentication ==="
# Q.13 - ssh -V outputs to stderr, redirect 2>&1 to capture
ssh -V 2>&1

# Q.14 & Q.15 - Create practice SSH key pair in isolated folder and display only .pub
LAB_DIR="$HOME/git_prework/l2_q15"
mkdir -p "$LAB_DIR"
rm -f "$LAB_DIR/practice_ed25519" "$LAB_DIR/practice_ed25519.pub"
ssh-keygen -t ed25519 -C "student@example.com" -f "$LAB_DIR/practice_ed25519" -N "" >/dev/null
echo "Public key:"
cat "$LAB_DIR/practice_ed25519.pub"

echo "=== Optional Practice (Q.17 - Q.20) ==="
# Q.18 - Correct mistyped email
git config --global user.email "wrong@example.com"
git config --global user.email "student@example.com"
git config --global --get user.email

# Q.19 - Check permissions on practice SSH key pair
LAB_DIR="$HOME/git_prework/l2_q19"
mkdir -p "$LAB_DIR"
rm -f "$LAB_DIR/practice_ed25519" "$LAB_DIR/practice_ed25519.pub"
ssh-keygen -t ed25519 -C "student@example.com" -f "$LAB_DIR/practice_ed25519" -N "" >/dev/null
ls -l "$LAB_DIR/practice_ed25519"
ls -l "$LAB_DIR/practice_ed25519.pub"

# Restore real Git identity if previously set
if [ -n "$ORIG_NAME" ]; then git config --global user.name "$ORIG_NAME"; fi
if [ -n "$ORIG_EMAIL" ]; then git config --global user.email "$ORIG_EMAIL"; fi

# Q.20 - Final Git Setup Check
echo "Git: $(git --version)"
echo "Name: $(git config --global --get user.name)"
echo "Email: $(git config --global --get user.email)"
echo "Default branch: $(git config --global --get init.defaultBranch)"
echo "SSH: $(ssh -V 2>&1)"
