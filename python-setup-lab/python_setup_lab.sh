#!/bin/bash

# Detect Python 3.11 or fallback to python
if command -v py >/dev/null 2>&1 && py -3.11 --version >/dev/null 2>&1; then
    PY_CMD="py -3.11"
elif command -v python3.11 >/dev/null 2>&1; then
    PY_CMD="python3.11"
elif command -v python3 >/dev/null 2>&1; then
    PY_CMD="python3"
else
    PY_CMD="python"
fi

echo "=== Part 1: Verify Python and Run Code ==="
# Q.1 - Verify Python version
$PY_CMD --version

# Q.2 - Interactive evaluation equivalent (2 + 3)
$PY_CMD -c "print(2 + 3)"

# Q.3 - Run scripts/check_orders.py
mkdir -p scripts
printf 'print("Python script is running")\n' > scripts/check_orders.py
$PY_CMD scripts/check_orders.py

echo "=== Part 2: Virtual Environment Setup & Verification ==="
# Q.19 (Before activation) - System interpreter path
echo "Before activation:"
$PY_CMD -c "import sys; print(sys.executable)"

# Q.6 & Q.7 - Create and activate .venv
rm -rf .venv
$PY_CMD -m venv .venv
if [ -f ".venv/Scripts/activate" ]; then
    source .venv/Scripts/activate
else
    source .venv/bin/activate
fi

echo "After activation:"
python -c "import sys; print(sys.executable)"

echo "=== Part 3: pip and Project Dependencies ==="
# Q.9 - Inspect installed packages
python -m pip list

# Q.10 - Install and import requests
python -m pip install --quiet requests
python -c "import requests; print(requests.__name__)"

# Q.11 - Create requirements.txt
printf "requests\n" > requirements.txt
cat requirements.txt

echo "=== Part 4: Reproducibility & Deactivation ==="
# Q.13 - Create dependency snapshot
python -m pip freeze > requirements_snapshot.txt
cat requirements_snapshot.txt

# Q.15 - Diagnose interpreter & package installation
python -m pip show requests | grep -E "^(Name|Version|Location):"

# Q.14 - Deactivate and reactivate
deactivate
if [ -f ".venv/Scripts/activate" ]; then
    source .venv/Scripts/activate
else
    source .venv/bin/activate
fi
echo "Reactivated interpreter:"
python -c "import sys; print(sys.executable)"

echo "=== Optional Practice (Q.17, Q.18, Q.20) ==="
# Q.17 - Build project structure files
printf "# Orders Python Project\n\nClean Python 3.11 virtual environment setup lab.\n" > README.md
printf 'print("Orders project ready")\n' > scripts/process_orders.py
python scripts/process_orders.py

# Q.20 - Complete environment verification script
printf "import requests\nprint('Environment ready')\n" > scripts/check_env.py
python scripts/check_env.py

# Q.18 - Test recreating dependencies in .venv_test (in temp folder so repo stays clean)
TEMP_TEST="$HOME/python_prework_venv_test"
rm -rf "$TEMP_TEST"
$PY_CMD -m venv "$TEMP_TEST"
if [ -f "$TEMP_TEST/Scripts/activate" ]; then
    source "$TEMP_TEST/Scripts/activate"
else
    source "$TEMP_TEST/bin/activate"
fi
python -m pip install --quiet -r requirements.txt
python -c "import requests; print('Fresh venv verified:', requests.__name__)"
deactivate
