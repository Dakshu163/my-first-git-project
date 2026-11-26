#!/bin/bash

echo "=== Part 1: Navigation and Listing ==="
# Q.1
mkdir -p "$HOME/linux_prework/l2_q1"
cd "$HOME/linux_prework/l2_q1" && pwd

# Q.2
LAB_DIR="$HOME/linux_prework/l2_q2"
mkdir -p "$LAB_DIR"
touch "$LAB_DIR/visible.txt" "$LAB_DIR/.hidden.txt"
ls -la "$LAB_DIR"

# Q.3
mkdir -p "$HOME/linux_prework/l2_q3/project/data"
cd "$HOME/linux_prework/l2_q3/project/data" && cd .. && pwd

echo "=== Part 2: Create Files and Directories ==="
# Q.5
LAB_DIR="$HOME/linux_prework/l2_q5"
mkdir -p "$LAB_DIR/project/src" "$LAB_DIR/project/data/raw" "$LAB_DIR/project/output"
ls -la "$LAB_DIR/project"

# Q.6
LAB_DIR="$HOME/linux_prework/l2_q6"
mkdir -p "$LAB_DIR"
touch "$LAB_DIR/sales.csv" "$LAB_DIR/customers.csv" "$LAB_DIR/README.txt"
ls -l "$LAB_DIR"

# Q.7
LAB_DIR="$HOME/linux_prework/l2_q7"
mkdir -p "$LAB_DIR"
printf "Linux file practice\n" > "$LAB_DIR/message.txt"
cat "$LAB_DIR/message.txt"

echo "=== Part 3: Copy, Move, and Rename ==="
# Q.9
LAB_DIR="$HOME/linux_prework/l2_q9"
mkdir -p "$LAB_DIR"
printf "backup practice\n" > "$LAB_DIR/source.txt"
cp "$LAB_DIR/source.txt" "$LAB_DIR/backup.txt"
cat "$LAB_DIR/backup.txt"

# Q.10
LAB_DIR="$HOME/linux_prework/l2_q10"
mkdir -p "$LAB_DIR/input" "$LAB_DIR/archive"
printf "id,value\n1,100\n" > "$LAB_DIR/input/data.csv"
cp "$LAB_DIR/input/data.csv" "$LAB_DIR/archive/"
ls -l "$LAB_DIR/archive"

# Q.11
LAB_DIR="$HOME/linux_prework/l2_q11"
mkdir -p "$LAB_DIR/input" "$LAB_DIR/output"
printf "id,value\n1,50\n" > "$LAB_DIR/input/result.tmp"
mv "$LAB_DIR/input/result.tmp" "$LAB_DIR/output/result.csv"
ls -la "$LAB_DIR/output"

echo "=== Part 4: Safe Removal ==="
# Q.13
LAB_DIR="$HOME/linux_prework/l2_q13"
mkdir -p "$LAB_DIR"
touch "$LAB_DIR/delete_me.txt"
rm "$LAB_DIR/delete_me.txt"
ls -la "$LAB_DIR"

# Q.14
LAB_DIR="$HOME/linux_prework/l2_q14"
mkdir -p "$LAB_DIR/empty_folder"
rmdir "$LAB_DIR/empty_folder"
ls -la "$LAB_DIR"

# Q.15
LAB_DIR="$HOME/linux_prework/l2_q15"
mkdir -p "$LAB_DIR/not_empty"
touch "$LAB_DIR/not_empty/keep.txt"
rm "$LAB_DIR/not_empty/keep.txt"
rmdir "$LAB_DIR/not_empty"
ls -la "$LAB_DIR"

echo "=== Optional Practice (Q.17 - Q.20) ==="
# Q.17
LAB_DIR="$HOME/linux_prework/l2_q17"
mkdir -p "$LAB_DIR/project/input" "$LAB_DIR/project/output"
touch "$LAB_DIR/project/input/a.csv" "$LAB_DIR/project/output/result.csv"
ls -R "$LAB_DIR/project"

# Q.18
LAB_DIR="$HOME/linux_prework/l2_q18"
mkdir -p "$LAB_DIR/input" "$LAB_DIR/archive"
touch "$LAB_DIR/input/a.csv" "$LAB_DIR/input/b.csv" "$LAB_DIR/input/c.csv" "$LAB_DIR/input/readme.txt"
cp "$LAB_DIR"/input/*.csv "$LAB_DIR/archive/"
ls -l "$LAB_DIR/archive"

# Q.19
LAB_DIR="$HOME/linux_prework/l2_q19"
mkdir -p "$LAB_DIR"
touch "$LAB_DIR/raw_01.txt" "$LAB_DIR/raw_02.txt"
mv "$LAB_DIR/raw_01.txt" "$LAB_DIR/processed_01.txt"
mv "$LAB_DIR/raw_02.txt" "$LAB_DIR/processed_02.txt"
ls -l "$LAB_DIR"

# Q.20
LAB_DIR="$HOME/linux_prework/l2_q20"
mkdir -p "$LAB_DIR/input" "$LAB_DIR/archive" "$LAB_DIR/output"
printf "id,amount\n1,100\n" > "$LAB_DIR/input/sales.csv"
cp "$LAB_DIR/input/sales.csv" "$LAB_DIR/archive/sales.csv"
mv "$LAB_DIR/input/sales.csv" "$LAB_DIR/output/sales.csv"
ls -la "$LAB_DIR/archive" "$LAB_DIR/output"
