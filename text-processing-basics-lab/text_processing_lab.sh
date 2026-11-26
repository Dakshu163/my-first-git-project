#!/bin/bash

echo "=== Part 1: Start with awk ==="
# Q.1 - Print complete lines with awk
LAB_DIR="$HOME/linux_prework/l5_q1"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/app.log" <<'INNER_EOF'
INFO application started
INFO request received
WARN response slow
ERROR database failed
INFO application stopped
INNER_EOF
awk '{print $0}' "$LAB_DIR/app.log"

# Q.2 - Print only the first three lines with NR
LAB_DIR="$HOME/linux_prework/l5_q2"
mkdir -p "$LAB_DIR"
printf "one\ntwo\nthree\nfour\nfive\n" > "$LAB_DIR/words.txt"
awk 'NR <= 3 {print $0}' "$LAB_DIR/words.txt"

# Q.3 - Extract IP address and request path
LAB_DIR="$HOME/linux_prework/l5_q3"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/access.log" <<'INNER_EOF'
10.0.0.1 GET /home 200
10.0.0.2 GET /products 200
10.0.0.3 POST /login 500
INNER_EOF
awk '{print $1, $3}' "$LAB_DIR/access.log"

echo "=== Part 2: Filter and Change Text ==="
# Q.5 - Filter HTTP error codes (404 and 500)
LAB_DIR="$HOME/linux_prework/l5_q5"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/access.log" <<'INNER_EOF'
10.0.0.1 GET /home 200
10.0.0.2 GET /missing 404
10.0.0.3 POST /login 500
10.0.0.4 GET /products 200
INNER_EOF
awk '$4 == 404 || $4 == 500 {print $0}' "$LAB_DIR/access.log"

# Q.6 - Replace text with sed (example.com -> example.org)
LAB_DIR="$HOME/linux_prework/l5_q6"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/emails.txt" <<'INNER_EOF'
rahul@example.com
priya@example.com
amit@example.com
INNER_EOF
sed 's/example\.com/example.org/g' "$LAB_DIR/emails.txt"

# Q.7 - Remove blank lines with sed
LAB_DIR="$HOME/linux_prework/l5_q7"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/notes.txt" <<'INNER_EOF'
first line

second line

third line
INNER_EOF
sed '/^$/d' "$LAB_DIR/notes.txt"

echo "=== Part 3: Work with CSV Fields and Counts ==="
# Q.9 - Comma field separator in awk
LAB_DIR="$HOME/linux_prework/l5_q9"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/users.csv" <<'INNER_EOF'
user_id,user_name,city
1,Rahul,Pune
2,Priya,Mumbai
3,Amit,Nashik
INNER_EOF
awk -F',' 'NR > 1 {print $2, $3}' "$LAB_DIR/users.csv"

# Q.10 - Filter CSV rows by city (Pune)
LAB_DIR="$HOME/linux_prework/l5_q10"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/users.csv" <<'INNER_EOF'
user_id,user_name,city
1,Rahul,Pune
2,Priya,Mumbai
3,Sneha,Pune
4,Amit,Nashik
INNER_EOF
awk -F',' 'NR > 1 && $3 == "Pune" {print $1, $2}' "$LAB_DIR/users.csv"

# Q.11 - Count requests by HTTP status code
LAB_DIR="$HOME/linux_prework/l5_q11"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/access.log" <<'INNER_EOF'
10.0.0.1 GET /home 200
10.0.0.2 GET /products 200
10.0.0.3 GET /missing 404
10.0.0.4 POST /login 500
10.0.0.5 GET /home 200
10.0.0.6 GET /missing 404
INNER_EOF
awk '{counts[$4]++} END {for (status in counts) print status, counts[status]}' "$LAB_DIR/access.log" | sort -n

echo "=== Part 4: Combine Text Processing Commands ==="
# Q.13 - Count requests per IP
LAB_DIR="$HOME/linux_prework/l5_q13"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/access.log" <<'INNER_EOF'
10.0.0.1 GET /home 200
10.0.0.2 GET /home 200
10.0.0.1 GET /cart 200
10.0.0.3 GET /home 404
10.0.0.1 POST /login 200
INNER_EOF
awk '{count[$1]++} END {for (ip in count) print count[ip], ip}' "$LAB_DIR/access.log" | sort -nr

# Q.14 - Normalise multiple spaces with sed
LAB_DIR="$HOME/linux_prework/l5_q14"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/text.txt" <<'INNER_EOF'
This   is    Linux.
Text      processing    is useful.
INNER_EOF
sed -E 's/ +/ /g' "$LAB_DIR/text.txt"

# Q.15 - Make a safe in-place change with backup
LAB_DIR="$HOME/linux_prework/l5_q15"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/agents.txt" <<'INNER_EOF'
Googlebot
Mozilla
Googlebot
INNER_EOF
cp "$LAB_DIR/agents.txt" "$LAB_DIR/agents.txt.bak"
sed -i 's/Googlebot/SearchBot/g' "$LAB_DIR/agents.txt"
echo "Changed file:"
cat "$LAB_DIR/agents.txt"
echo "Backup:"
cat "$LAB_DIR/agents.txt.bak"

echo "=== Optional Practice (Q.17 - Q.20) ==="
# Q.17 - Top three IPs by request count
LAB_DIR="$HOME/linux_prework/l5_q17"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/access.log" <<'INNER_EOF'
10.0.0.1 GET /a 200
10.0.0.2 GET /b 200
10.0.0.1 GET /c 200
10.0.0.3 GET /d 200
10.0.0.2 GET /e 200
10.0.0.1 GET /f 200
10.0.0.4 GET /g 200
INNER_EOF
awk '{count[$1]++} END {for (ip in count) print count[ip], ip}' "$LAB_DIR/access.log" | sort -nr | head -n 3

# Q.18 - Count requests by date
LAB_DIR="$HOME/linux_prework/l5_q18"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/access.log" <<'INNER_EOF'
2026-08-01 10.0.0.1 /home
2026-08-01 10.0.0.2 /cart
2026-08-02 10.0.0.1 /home
2026-08-02 10.0.0.3 /login
2026-08-02 10.0.0.4 /products
INNER_EOF
awk '{count[$1]++} END {for (date in count) print date, count[date]}' "$LAB_DIR/access.log" | sort

# Q.19 - Detect rows with wrong number of CSV fields (NF != 3)
LAB_DIR="$HOME/linux_prework/l5_q19"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/users.csv" <<'INNER_EOF'
id,name,city
1,Rahul,Pune
2,Priya,Mumbai
3,BrokenRow
4,Sneha,Pune
INNER_EOF
awk -F',' 'NF != 3 {print "Malformed:", $0}' "$LAB_DIR/users.csv"

# Q.20 - Build a small log summary
LAB_DIR="$HOME/linux_prework/l5_q20"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/access.log" <<'INNER_EOF'
10.0.0.1 GET /home 200
10.0.0.2 GET /products 200
10.0.0.1 GET /missing 404
10.0.0.3 POST /login 500
10.0.0.1 GET /home 200
10.0.0.2 GET /missing 404
INNER_EOF
echo "Counts by status:"
awk '{count[$4]++} END {for (status in count) print status, count[status]}' "$LAB_DIR/access.log" | sort -n
echo "Counts by IP:"
awk '{count[$1]++} END {for (ip in count) print count[ip], ip}' "$LAB_DIR/access.log" | sort -nr
echo "4xx and 5xx rows:"
awk '$4 >= 400 {print $0}' "$LAB_DIR/access.log"
