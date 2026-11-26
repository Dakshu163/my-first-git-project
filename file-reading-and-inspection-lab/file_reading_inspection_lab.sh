#!/bin/bash

echo "=== Part 1: Read Files ==="
# Q.1 - Read a whole file with cat
LAB_DIR="$HOME/linux_prework/l3_q1"
mkdir -p "$LAB_DIR"
printf "Rahul\nPriya\nAmit\n" > "$LAB_DIR/customers.txt"
cat "$LAB_DIR/customers.txt"

# Q.2 - Create 10 numbered lines (normally inspected with less)
LAB_DIR="$HOME/linux_prework/l3_q2"
mkdir -p "$LAB_DIR"
printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" > "$LAB_DIR/numbers.txt"
cat "$LAB_DIR/numbers.txt"

# Q.3 - Create app.log and filter ERROR lines (simulating /ERROR inside less)
LAB_DIR="$HOME/linux_prework/l3_q3"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/app.log" <<'INNER_EOF'
INFO application started
WARN disk usage high
INFO request completed
ERROR database connection failed
INFO retry started
ERROR retry failed
INNER_EOF
grep "ERROR" "$LAB_DIR/app.log"

echo "=== Part 2: Inspect the Beginning and End ==="
# Q.5 - Show the first five lines
LAB_DIR="$HOME/linux_prework/l3_q5"
mkdir -p "$LAB_DIR"
printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" > "$LAB_DIR/numbers.txt"
head -n 5 "$LAB_DIR/numbers.txt"

# Q.6 - Show CSV header and first three data rows
LAB_DIR="$HOME/linux_prework/l3_q6"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/customers.csv" <<'INNER_EOF'
id,name
1,Rahul
2,Priya
3,Amit
4,Sneha
5,Rohan
INNER_EOF
head -n 4 "$LAB_DIR/customers.csv"

# Q.7 - Show the last four lines
LAB_DIR="$HOME/linux_prework/l3_q7"
mkdir -p "$LAB_DIR"
printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" > "$LAB_DIR/numbers.txt"
tail -n 4 "$LAB_DIR/numbers.txt"

echo "=== Part 3: Count and Extract Data ==="
# Q.9 - Count lines with wc -l
LAB_DIR="$HOME/linux_prework/l3_q9"
mkdir -p "$LAB_DIR"
printf "red\nblue\ngreen\nyellow\n" > "$LAB_DIR/colours.txt"
wc -l "$LAB_DIR/colours.txt"

# Q.10 - Count CSV data rows (skipping header)
LAB_DIR="$HOME/linux_prework/l3_q10"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/customers.csv" <<'INNER_EOF'
id,name
1,Rahul
2,Priya
3,Amit
4,Sneha
INNER_EOF
tail -n +2 "$LAB_DIR/customers.csv" | wc -l

# Q.11 - Extract customer_id and city columns with cut
LAB_DIR="$HOME/linux_prework/l3_q11"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/customers.csv" <<'INNER_EOF'
customer_id,name,city
1,Rahul,Pune
2,Priya,Mumbai
3,Amit,Nashik
INNER_EOF
cut -d',' -f1,3 "$LAB_DIR/customers.csv"

echo "=== Part 4: Sort and Count Repeated Values ==="
# Q.13 - Sort text alphabetically
LAB_DIR="$HOME/linux_prework/l3_q13"
mkdir -p "$LAB_DIR"
printf "Pune\nMumbai\nDelhi\nAhmedabad\n" > "$LAB_DIR/cities.txt"
sort "$LAB_DIR/cities.txt"

# Q.14 - Normal sort vs Numeric sort
LAB_DIR="$HOME/linux_prework/l3_q14"
mkdir -p "$LAB_DIR"
printf "20\n3\n100\n15\n" > "$LAB_DIR/numbers.txt"
echo "Normal sort:"
sort "$LAB_DIR/numbers.txt"
echo "Numeric sort:"
sort -n "$LAB_DIR/numbers.txt"

# Q.15 - Count repeated values with sort | uniq -c
LAB_DIR="$HOME/linux_prework/l3_q15"
mkdir -p "$LAB_DIR"
printf "Pune\nMumbai\nPune\nDelhi\nMumbai\nPune\n" > "$LAB_DIR/cities.txt"
sort "$LAB_DIR/cities.txt" | uniq -c

echo "=== Optional Practice (Q.17 - Q.20) ==="
# Q.17 - Three largest values
LAB_DIR="$HOME/linux_prework/l3_q17"
mkdir -p "$LAB_DIR"
printf "120\n450\n75\n900\n300\n" > "$LAB_DIR/amounts.txt"
sort -nr "$LAB_DIR/amounts.txt" | head -n 3

# Q.18 - Most common cities highest to lowest
LAB_DIR="$HOME/linux_prework/l3_q18"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/customers.csv" <<'INNER_EOF'
id,city
1,Pune
2,Mumbai
3,Pune
4,Delhi
5,Mumbai
6,Pune
INNER_EOF
cut -d',' -f2 "$LAB_DIR/customers.csv" | tail -n +2 | sort | uniq -c | sort -nr

# Q.19 - Appending new log line (simulating tail -f append)
LAB_DIR="$HOME/linux_prework/l3_q19"
mkdir -p "$LAB_DIR"
printf "INFO started\n" > "$LAB_DIR/app.log"
printf "ERROR connection failed\n" >> "$LAB_DIR/app.log"
cat "$LAB_DIR/app.log"

# Q.20 - Quick CSV inspection workflow
LAB_DIR="$HOME/linux_prework/l3_q20"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/orders.csv" <<'INNER_EOF'
order_id,amount
101,250
102,100
103,450
104,200
105,700
INNER_EOF
echo "Header + first 2 rows:"
head -n 3 "$LAB_DIR/orders.csv"
echo "Last 2 rows:"
tail -n 2 "$LAB_DIR/orders.csv"
echo "Data row count:"
tail -n +2 "$LAB_DIR/orders.csv" | wc -l
echo "Amounts largest to smallest:"
cut -d',' -f2 "$LAB_DIR/orders.csv" | tail -n +2 | sort -nr
