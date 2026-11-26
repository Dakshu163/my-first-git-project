#!/bin/bash

echo "=== Q.1: Create Two Manual Versions ==="
LAB_DIR="$HOME/git_prework/l1_q1"
mkdir -p "$LAB_DIR"

cat > "$LAB_DIR/sales_notes_v1.txt" <<'INNER_EOF'
Daily sales report
Source: store system
INNER_EOF

cat > "$LAB_DIR/sales_notes_v2.txt" <<'INNER_EOF'
Daily sales report
Source: store system
Refresh: every morning
INNER_EOF

echo "Version 1:"
cat "$LAB_DIR/sales_notes_v1.txt"
echo "Version 2:"
cat "$LAB_DIR/sales_notes_v2.txt"

echo "=== Q.2: Compare Two File Versions with diff ==="
LAB_DIR="$HOME/git_prework/l1_q2"
mkdir -p "$LAB_DIR"

cat > "$LAB_DIR/config_old.txt" <<'INNER_EOF'
environment=dev
batch_size=100
INNER_EOF

cat > "$LAB_DIR/config_new.txt" <<'INNER_EOF'
environment=dev
batch_size=500
INNER_EOF

diff "$LAB_DIR/config_old.txt" "$LAB_DIR/config_new.txt" || true

echo "=== Q.7: Restore a Manual Earlier Version ==="
LAB_DIR="$HOME/git_prework/l1_q7"
mkdir -p "$LAB_DIR"

printf "status=correct\n" > "$LAB_DIR/report_saved.txt"
cp "$LAB_DIR/report_saved.txt" "$LAB_DIR/report_current.txt"
printf "status=wrong\n" > "$LAB_DIR/report_current.txt"

echo "Before restore:"
cat "$LAB_DIR/report_current.txt"

cp "$LAB_DIR/report_saved.txt" "$LAB_DIR/report_current.txt"
echo "After restore:"
cat "$LAB_DIR/report_current.txt"

echo "=== Q.13: Separate Project Files from Generated Data ==="
LAB_DIR="$HOME/git_prework/l1_q13"
mkdir -p "$LAB_DIR/project/notes" "$LAB_DIR/project/output"

printf "Daily pipeline design\n" > "$LAB_DIR/project/notes/design.txt"
printf "1000 generated rows\n" > "$LAB_DIR/project/output/result.txt"

find "$LAB_DIR/project" -type f -print

echo "=== Q.18: Compare Two Three-Line Configurations ==="
LAB_DIR="$HOME/git_prework/l1_q18"
mkdir -p "$LAB_DIR"

cat > "$LAB_DIR/old.conf" <<'INNER_EOF'
environment=dev
batch_size=100
retries=1
INNER_EOF

cat > "$LAB_DIR/new.conf" <<'INNER_EOF'
environment=prod
batch_size=500
retries=1
INNER_EOF

diff "$LAB_DIR/old.conf" "$LAB_DIR/new.conf" || true
