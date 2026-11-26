#!/bin/bash

echo "=== Part 1: Build a Clear Repository Structure ==="
# Q.1 - Create a simple project skeleton
LAB_DIR="$HOME/git_prework/l6_q1/project"
rm -rf "$HOME/git_prework/l6_q1"
mkdir -p "$LAB_DIR/config" "$LAB_DIR/data" "$LAB_DIR/scripts" "$LAB_DIR/sql" "$LAB_DIR/docs"
printf "# Practice Project\n" > "$LAB_DIR/README.md"
find "$LAB_DIR" -maxdepth 2 -print | sort

# Q.2 - Separate sample data from raw data
LAB_DIR="$HOME/git_prework/l6_q2/project"
rm -rf "$HOME/git_prework/l6_q2"
mkdir -p "$LAB_DIR/data/raw" "$LAB_DIR/data/sample"
printf "large private source data\n" > "$LAB_DIR/data/raw/orders.csv"
printf "id,amount\n1,100\n2,200\n" > "$LAB_DIR/data/sample/orders_sample.csv"
find "$LAB_DIR/data" -type f -print | sort

# Q.3 - Separate code, SQL, and documentation
LAB_DIR="$HOME/git_prework/l6_q3/project"
rm -rf "$HOME/git_prework/l6_q3"
mkdir -p "$LAB_DIR/scripts" "$LAB_DIR/sql" "$LAB_DIR/docs"
printf "Process orders from source to target\n" > "$LAB_DIR/scripts/process_orders.txt"
cat > "$LAB_DIR/sql/create_orders.sql" <<'INNER_EOF'
CREATE TABLE orders (
    order_id INT
);
INNER_EOF
printf "# Architecture\n\nSource -> Processing -> Target\n" > "$LAB_DIR/docs/architecture.md"
find "$LAB_DIR" -type f -print | sort

echo "=== Part 2: Add Important Project Files ==="
# Q.5 - Create a root README
LAB_DIR="$HOME/git_prework/l6_q5/project"
rm -rf "$HOME/git_prework/l6_q5"
mkdir -p "$LAB_DIR/scripts" "$LAB_DIR/sql" "$LAB_DIR/docs"
cat > "$LAB_DIR/README.md" <<'INNER_EOF'
# Orders Practice Project

A small project used to demonstrate a clear repository structure.

Main folders:

- scripts/ - processing files
- sql/ - SQL files
- docs/ - project documentation
INNER_EOF
cat "$LAB_DIR/README.md"

# Q.6 - Create a .gitignore
LAB_DIR="$HOME/git_prework/l6_q6/project"
rm -rf "$HOME/git_prework/l6_q6"
mkdir -p "$LAB_DIR/data/raw" && cd "$LAB_DIR"
git init -b main >/dev/null
printf "SECRET=practice\n" > .env
printf "1,100\n" > data/raw/orders.csv
printf "temporary log\n" > app.log
printf "# Project\n" > README.md
cat > .gitignore <<'INNER_EOF'
.env
data/raw/
*.log
INNER_EOF
git status --short

# Q.7 - Create a dependency file (requirements.txt)
LAB_DIR="$HOME/git_prework/l6_q7/project"
rm -rf "$HOME/git_prework/l6_q7"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/requirements.txt" <<'INNER_EOF'
pandas
pyarrow
INNER_EOF
cat "$LAB_DIR/requirements.txt"

echo "=== Part 3: Organise Configuration, Data, and Documentation ==="
# Q.9 - Store a safe configuration example
LAB_DIR="$HOME/git_prework/l6_q9/project"
rm -rf "$HOME/git_prework/l6_q9"
mkdir -p "$LAB_DIR/config"
cat > "$LAB_DIR/config/config.example.json" <<'INNER_EOF'
{
  "environment": "dev",
  "database_host": "localhost"
}
INNER_EOF
cat "$LAB_DIR/config/config.example.json"

# Q.10 - Keep secrets outside the repository
LAB_DIR="$HOME/git_prework/l6_q10/project"
rm -rf "$HOME/git_prework/l6_q10"
mkdir -p "$LAB_DIR/config" && cd "$LAB_DIR"
git init -b main >/dev/null
cat > config/config.example.env <<'INNER_EOF'
DB_HOST=
DB_USER=
DB_PASSWORD=
INNER_EOF
cat > .env <<'INNER_EOF'
DB_HOST=localhost
DB_USER=practice
DB_PASSWORD=do_not_commit
INNER_EOF
printf ".env\n" > .gitignore
git status --short

# Q.11 - Add architecture documentation
LAB_DIR="$HOME/git_prework/l6_q11/project"
rm -rf "$HOME/git_prework/l6_q11"
mkdir -p "$LAB_DIR/docs"
cat > "$LAB_DIR/docs/architecture.md" <<'INNER_EOF'
# Architecture

~~~text
Source
  |
  v
Processing
  |
  v
Target
~~~
INNER_EOF
cat "$LAB_DIR/docs/architecture.md"

echo "=== Part 4: Review and Version the Structure ==="
# Q.14 - Track an empty directory with .gitkeep
LAB_DIR="$HOME/git_prework/l6_q14/project"
rm -rf "$HOME/git_prework/l6_q14"
mkdir -p "$LAB_DIR/data/sample"
touch "$LAB_DIR/data/sample/.gitkeep"
ls -la "$LAB_DIR/data/sample"

# Q.15 - Commit a clean project skeleton
LAB_DIR="$HOME/git_prework/l6_q15/project"
rm -rf "$HOME/git_prework/l6_q15"
mkdir -p "$LAB_DIR/config" "$LAB_DIR/scripts" "$LAB_DIR/sql" "$LAB_DIR/docs" "$LAB_DIR/data/sample"
cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "# Structured Project\n" > README.md
cat > .gitignore <<'INNER_EOF'
.env
data/raw/
data/output/
*.log
INNER_EOF
printf "pandas\n" > requirements.txt
cat > config/config.example.json <<'INNER_EOF'
{
  "environment": "dev"
}
INNER_EOF
touch scripts/.gitkeep sql/.gitkeep docs/.gitkeep data/sample/.gitkeep
git add .
git status --short
git commit -m "Add clean project structure" >/dev/null
git log --oneline -n 1

echo "=== Optional Practice (Q.18 - Q.20) ==="
# Q.18 - Check what Git would track
LAB_DIR="$HOME/git_prework/l6_q18/project"
rm -rf "$HOME/git_prework/l6_q18"
mkdir -p "$LAB_DIR/data/raw" "$LAB_DIR/data/sample" && cd "$LAB_DIR"
git init -b main >/dev/null
printf "# Project\n" > README.md
printf "1,100\n" > data/raw/orders.csv
printf "1,10\n" > data/sample/orders_sample.csv
printf "TOKEN=practice\n" > .env
cat > .gitignore <<'INNER_EOF'
.env
data/raw/
INNER_EOF
git status --short

# Q.19 - Create a repository map
LAB_DIR="$HOME/git_prework/l6_q19/project"
rm -rf "$HOME/git_prework/l6_q19"
mkdir -p "$LAB_DIR/docs"
cat > "$LAB_DIR/docs/project_structure.md" <<'INNER_EOF'
# Project Structure

- config/ - non-secret configuration examples
- data/sample/ - small safe input examples
- scripts/ - processing or utility code
- sql/ - SQL files
- docs/ - detailed project documentation
- tests/ - test files when the project uses automated tests
INNER_EOF
cat "$LAB_DIR/docs/project_structure.md"

# Q.20 - Build a complete clean repository skeleton
LAB_DIR="$HOME/git_prework/l6_q20/project"
rm -rf "$HOME/git_prework/l6_q20"
mkdir -p "$LAB_DIR/config" "$LAB_DIR/data/sample" "$LAB_DIR/data/raw" "$LAB_DIR/data/output" \
         "$LAB_DIR/scripts" "$LAB_DIR/sql" "$LAB_DIR/docs" "$LAB_DIR/tests"
cd "$LAB_DIR"
git init -b main >/dev/null
git config user.name "Practice Student" && git config user.email "student@example.com"
printf "# Clean Repository\n" > README.md
printf "pandas\n" > requirements.txt
cat > .gitignore <<'INNER_EOF'
.env
data/raw/
data/output/
*.log
INNER_EOF
printf "TOKEN=practice\n" > .env
printf "private raw data\n" > data/raw/orders.csv
printf "generated output\n" > data/output/result.csv
printf "id,amount\n1,100\n" > data/sample/orders_sample.csv
touch config/.gitkeep scripts/.gitkeep sql/.gitkeep docs/.gitkeep tests/.gitkeep
echo "Normal status:"
git status --short
echo "Including ignored files:"
git status --short --ignored
git add .
git commit -m "Add clean repository skeleton" >/dev/null
git status --short
