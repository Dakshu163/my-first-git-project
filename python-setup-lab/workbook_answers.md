# Python Pre-Work — Lesson 1: Python Setup — Lab Answers
**Student:** Dakshayini M L

## MCQ Answers
- **Q.4 — Reusable Python Code:** **B** (A normal Python script or module)
- **Q.8 — Virtual Environment Purpose:** **B** (It isolates project-specific Python packages)
- **Q.12 — Reliable Package Installation:** **A** (`python -m pip install requests`)
- **Q.16 — Project Files:** **C** (`.venv/`)

## Written & Diagnostic Answers
- **Q.5 — PyCharm vs. Jupyter:**
  1. Explore a small dataset interactively -> **Jupyter**
  2. Organise reusable project scripts -> **PyCharm**
  3. Inspect intermediate results cell by cell -> **Jupyter**
  4. Work with project files and an interpreter configuration -> **PyCharm**
- **Q.15 — Diagnose an Interpreter Mismatch:** First check which Python interpreter is executing the script (`python -c "import sys; print(sys.executable)"`), then check where `requests` is installed (`python -m pip show requests`) to verify both point to the same `.venv` environment.
- **Q.19 — Interpreter Before vs. After Activation:** Before activation, `sys.executable` points to the global/system Python installation. After activating `.venv`, `sys.executable` points inside `.venv\Scripts\python.exe` (or `.venv/bin/python`), isolating project dependencies without modifying the system Python installation.
