#!/bin/bash

echo "=== Part 1: Explain the Project Clearly ==="
# Q.1 - Clear project title
LAB_DIR="$HOME/git_prework/l7_q1"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/README.md" <<'INNER_EOF'
# Orders Data Practice Project
INNER_EOF
cat "$LAB_DIR/README.md"

# Q.2 - One-paragraph overview
LAB_DIR="$HOME/git_prework/l7_q2"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/README.md" <<'INNER_EOF'
# Orders Data Practice Project

This project reads a small orders dataset, applies simple data-cleaning steps, and prepares a clean output that can be used for reporting practice.
INNER_EOF
cat "$LAB_DIR/README.md"

# Q.3 - Problem statement
LAB_DIR="$HOME/git_prework/l7_q3"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/README.md" <<'INNER_EOF'
# Orders Data Practice Project

## Problem Statement

Order data can arrive with inconsistent values and may not be ready for reporting. This project demonstrates a small workflow for organising the source data and producing a cleaner reporting-ready file.
INNER_EOF
cat "$LAB_DIR/README.md"

echo "=== Part 2: Document Setup and Usage ==="
# Q.5 - Prerequisites
LAB_DIR="$HOME/git_prework/l7_q5"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/README.md" <<'INNER_EOF'
# Orders Data Practice Project

## Prerequisites

Before using this project, make sure you have:

- Git
- Python 3
INNER_EOF
cat "$LAB_DIR/README.md"

# Q.6 - Setup steps
LAB_DIR="$HOME/git_prework/l7_q6"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/README.md" <<'INNER_EOF'
# Orders Data Practice Project

## Setup

1. Open a terminal.
2. Move into the project directory.
3. Check the available files.

~~~bash
cd orders-data-project
ls -la
~~~
INNER_EOF
cat "$LAB_DIR/README.md"

# Q.7 - Usage example
LAB_DIR="$HOME/git_prework/l7_q7"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/README.md" <<'INNER_EOF'
# Orders Data Practice Project

## Usage

Run the processing script from the project root:

~~~bash
python3 scripts/process_orders.py
~~~

The command reads the practice input and creates the project output.
INNER_EOF
cat "$LAB_DIR/README.md"

echo "=== Part 3: Explain Structure, Architecture, and Output ==="
# Q.9 - Folder structure
LAB_DIR="$HOME/git_prework/l7_q9"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/README.md" <<'INNER_EOF'
# Orders Data Practice Project

## Project Structure

~~~text
config/       configuration examples
data/sample/  small safe sample data
scripts/      processing scripts
sql/          SQL files
docs/         detailed documentation
~~~
INNER_EOF
cat "$LAB_DIR/README.md"

# Q.10 - Small architecture diagram
LAB_DIR="$HOME/git_prework/l7_q10"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/README.md" <<'INNER_EOF'
# Orders Data Practice Project

## Architecture

~~~text
Sample Data
    |
    v
Processing
    |
    v
Clean Output
~~~
INNER_EOF
cat "$LAB_DIR/README.md"

# Q.11 - Expected output example
LAB_DIR="$HOME/git_prework/l7_q11"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/README.md" <<'INNER_EOF'
# Orders Data Practice Project

## Expected Output

A successful practice run should print:

~~~text
Processed rows: 3
Rejected rows: 1
~~~
INNER_EOF
cat "$LAB_DIR/README.md"

echo "=== Part 4: Make the README Safer and Easier to Use ==="
# Q.13 - Configuration note
LAB_DIR="$HOME/git_prework/l7_q13"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/README.md" <<'INNER_EOF'
# Orders Data Practice Project

## Configuration

Use `config.example.env` to see which configuration values are required.

Create your own local `.env` file for real values.

Do not commit passwords, tokens, or private keys to the repository.
INNER_EOF
cat "$LAB_DIR/README.md"

# Q.14 - Troubleshooting section
LAB_DIR="$HOME/git_prework/l7_q14"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/README.md" <<'INNER_EOF'
# Orders Data Practice Project

## Troubleshooting

### `python3: command not found`

Check that Python 3 is installed and available in your terminal.

### Input file not found

Make sure the sample file exists in the path shown in the project instructions.
INNER_EOF
cat "$LAB_DIR/README.md"

# Q.15 - Link to detailed documentation
LAB_DIR="$HOME/git_prework/l7_q15"
mkdir -p "$LAB_DIR/docs"
printf "# Architecture Details\n" > "$LAB_DIR/docs/architecture.md"
cat > "$LAB_DIR/README.md" <<'INNER_EOF'
# Orders Data Practice Project

## Documentation

See the [architecture notes](docs/architecture.md) for more detail.
INNER_EOF
cat "$LAB_DIR/README.md"

echo "=== Optional Practice (Q.19 - Q.20) ==="
# Q.19 - Check required README sections with grep
LAB_DIR="$HOME/git_prework/l7_q19"
mkdir -p "$LAB_DIR"
cat > "$LAB_DIR/README.md" <<'INNER_EOF'
# Orders Data Practice Project

## Problem Statement
Practice project.

## Architecture
Sample Data -> Processing -> Output

## Prerequisites
Python 3

## Setup
Open the project directory.

## Usage
Run the processing script.

## Project Structure
See project folders.

## Expected Output
Processed rows are displayed.

## Troubleshooting
Check paths and required tools.
INNER_EOF

for heading in \
  "Problem Statement" \
  "Architecture" \
  "Prerequisites" \
  "Setup" \
  "Usage" \
  "Project Structure" \
  "Expected Output" \
  "Troubleshooting"
do
    grep -n "## $heading" "$LAB_DIR/README.md"
done

# Q.20 - Write a complete README
LAB_DIR="$HOME/git_prework/l7_q20"
mkdir -p "$LAB_DIR/docs"
printf "# Architecture Details\n\nThe project uses a simple file-processing flow.\n" > "$LAB_DIR/docs/architecture.md"
cat > "$LAB_DIR/README.md" <<'INNER_EOF'
# Orders Data Practice Project

This project uses a small orders dataset to demonstrate a simple data-processing project structure.

## Problem Statement

Raw order data may need basic cleaning before it can be used for reporting. This project shows a small practice flow from sample input to clean output.

## Architecture

~~~text
Sample Orders
     |
     v
Processing Script
     |
     v
Clean Output
~~~

## Prerequisites

- Git
- Python 3

## Setup

Open a terminal and move to the project directory.

~~~bash
cd orders-data-project
~~~

## Usage

Run:

~~~bash
python3 scripts/process_orders.py
~~~

## Project Structure

~~~text
config/       configuration examples
data/sample/  safe sample data
scripts/      processing scripts
sql/          SQL files
docs/         detailed documentation
~~~

## Configuration

Use configuration example files as templates.

Do not commit passwords, tokens, or private keys.

## Expected Output

~~~text
Processed rows: 3
Rejected rows: 1
~~~

## Troubleshooting

If the input file is missing, verify the sample-data path.

If `python3` is not found, confirm Python 3 is installed.

## More Documentation

See [architecture details](docs/architecture.md).
INNER_EOF
cat "$LAB_DIR/README.md"
