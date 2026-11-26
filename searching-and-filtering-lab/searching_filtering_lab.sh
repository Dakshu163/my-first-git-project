#!/bin/bash

echo "=== Part 1: Find Files by Name and Type ==="
# Q.1 - Find all files in a directory
LAB_DIR="$HOME/linux_prework/l4_q1"
mkdir -p "$LAB_DIR/data"
touch "$LAB_DIR/app.log" "$LAB_DIR/notes.txt" "$LAB_DIR/data/customers.csv" "$LAB_DIR/data/orders.csv"
find "$LAB_DIR" -type f

# Q.2 - Find only .log files
LAB_DIR="$HOME/linux_prework/l4_q2"
mkdir -p "$LAB_DIR/server1" "$LAB_DIR/server2"
touch "$LAB_DIR/app.log" "$LAB_DIR/readme.txt" "$LAB_DIR/server1/service.log" "$LAB_DIR/server2/data.csv"
find "$LAB_DIR" -type f -name "*.log"

# Q.3 - Find files by part of the name (case-insensitive)
LAB_DIR="$HOME/linux_prework/l4_q3"
mkdir -p "$LAB_DIR"
touch "$LAB_DIR/error_app.log" "$LAB_DIR/sales.csv" "$LAB_DIR/app_error_01.log" "$LAB_DIR/readme.txt"
find "$LAB_DIR" -type f -iname "*error*"

echo "=== Part 2: Search Inside Files with grep ==="
# Q.5 - Find lines containing ERROR
LAB_DIR="$HOME/linux_prework/l4_q5"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/app.log" <<'INNER_EOF'
INFO started
ERROR connection failed
WARN retrying
ERROR retry failed
INNER_EOF
grep "ERROR" "$LAB_DIR/app.log"

# Q.6 - Show line numbers with matches
LAB_DIR="$HOME/linux_prework/l4_q6"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/app.log" <<'INNER_EOF'
INFO start
WARN low memory
INFO continue
WARN low disk
INNER_EOF
grep -n "WARN" "$LAB_DIR/app.log"

# Q.7 - Search recursively across several files
LAB_DIR="$HOME/linux_prework/l4_q7"
mkdir -p "$LAB_DIR/server1" "$LAB_DIR/server2"
printf "INFO ok\nERROR db failed\n" > "$LAB_DIR/server1/app.log"
printf "WARN slow\nERROR disk full\n" > "$LAB_DIR/server2/app.log"
grep -R -n "ERROR" "$LAB_DIR"

echo "=== Part 3: Count and Combine Search Conditions ==="
# Q.9 - Count matching lines
LAB_DIR="$HOME/linux_prework/l4_q9"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/app.log" <<'INNER_EOF'
ERROR first
INFO ok
ERROR second
INFO done
ERROR third
INNER_EOF
grep -c "ERROR" "$LAB_DIR/app.log"

# Q.10 - Search for more than one pattern (WARN or ERROR)
LAB_DIR="$HOME/linux_prework/l4_q10"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/app.log" <<'INNER_EOF'
INFO started
WARN low memory
ERROR database failed
INFO stopped
INNER_EOF
grep -E "WARN|ERROR" "$LAB_DIR/app.log"

# Q.11 - Find .log files and search their content
LAB_DIR="$HOME/linux_prework/l4_q11"
mkdir -p "$LAB_DIR/server1" "$LAB_DIR/server2"
printf "INFO ok\nERROR db failed\n" > "$LAB_DIR/server1/app.log"
printf "ERROR disk full\n" > "$LAB_DIR/server2/app.log"
printf "ERROR is only an example word here\n" > "$LAB_DIR/server2/readme.txt"
find "$LAB_DIR" -type f -name "*.log" -exec grep -H "ERROR" {} \;

echo "=== Part 4: Useful Search Filters ==="
# Q.13 - Find large practice files (> 1 KB)
LAB_DIR="$HOME/linux_prework/l4_q13"
mkdir -p "$LAB_DIR"
printf "small\n" > "$LAB_DIR/small.txt"
yes "large practice line" | head -n 100 > "$LAB_DIR/large.txt"
find "$LAB_DIR" -type f -size +1k -print

# Q.14 - Find files modified within last 7 days
LAB_DIR="$HOME/linux_prework/l4_q14"
mkdir -p "$LAB_DIR"
touch "$LAB_DIR/recent.log" "$LAB_DIR/old.log"
touch -d "20 days ago" "$LAB_DIR/old.log"
find "$LAB_DIR" -type f -mtime -7 -print

# Q.15 - Search a compressed .gz log
LAB_DIR="$HOME/linux_prework/l4_q15"
mkdir -p "$LAB_DIR"
printf "INFO started\nERROR compressed failure\n" > "$LAB_DIR/app.log"
gzip -c "$LAB_DIR/app.log" > "$LAB_DIR/app.log.gz"
if command -v zgrep >/dev/null 2>&1; then
    zgrep "ERROR" "$LAB_DIR/app.log.gz"
else
    gzip -dc "$LAB_DIR/app.log.gz" | grep "ERROR"
fi

echo "=== Optional Practice (Q.17 - Q.20) ==="
# Q.17 - Find duplicate file content via SHA-256 checksums
LAB_DIR="$HOME/linux_prework/l4_q17"
mkdir -p "$LAB_DIR"
printf "same data\n" > "$LAB_DIR/a.txt"
printf "same data\n" > "$LAB_DIR/b.txt"
printf "different data\n" > "$LAB_DIR/c.txt"
sha256sum "$LAB_DIR"/*.txt

# Q.18 - Show only filenames containing ERROR
LAB_DIR="$HOME/linux_prework/l4_q18"
mkdir -p "$LAB_DIR"
printf "INFO ok\n" > "$LAB_DIR/a.log"
printf "ERROR failed\n" > "$LAB_DIR/b.log"
printf "INFO start\nERROR timeout\n" > "$LAB_DIR/c.log"
grep -l "ERROR" "$LAB_DIR"/*.log

# Q.19 - Find error logs by name and content
LAB_DIR="$HOME/linux_prework/l4_q19"
mkdir -p "$LAB_DIR"
printf "INFO api healthy\n" > "$LAB_DIR/error_api.log"
printf "ERROR database failed\n" > "$LAB_DIR/error_db.log"
printf "ERROR normal file\n" > "$LAB_DIR/normal.log"
find "$LAB_DIR" -type f -iname "*error*" -exec grep -l "ERROR" {} \;

# Q.20 - Build a small error search report
LAB_DIR="$HOME/linux_prework/l4_q20"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/api.log" <<'INNER_EOF'
INFO request
ERROR timeout
INFO retry
INNER_EOF
cat > "$LAB_DIR/db.log" <<'INNER_EOF'
ERROR connection failed
ERROR retry failed
INNER_EOF
cat > "$LAB_DIR/payment.log" <<'INNER_EOF'
INFO payment accepted
INNER_EOF

echo "Log files:"
find "$LAB_DIR" -type f -name "*.log"

echo "ERROR counts:"
for file in "$LAB_DIR"/*.log; do
    count=$(grep -c "ERROR" "$file")
    echo "$(basename "$file"): $count"
done

echo "Files containing ERROR:"
grep -l "ERROR" "$LAB_DIR"/*.log
