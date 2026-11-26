# Git Pre-Work — Lesson 6: GitHub Project Structure — Lab Answers
**Student:** Dakshayini M L

## Part 1 — Build a Clear Repository Structure
- **Q.1 & Q.3:** Executed via `github_project_structure_lab.sh` (see `lab_output.txt`).
- **Q.2 — Sample vs. Raw Data:** `data/sample/` is safer to include in a shared repository because it holds small, non-sensitive example data; `data/raw/` contains large or private operational data and should be excluded via `.gitignore`.
- **Q.4 — MCQ:** **D** (It makes files easier to find and gives each type of content a clear place)

## Part 2 — Add Important Project Files
- **Q.5 & Q.6:** Executed via `github_project_structure_lab.sh`.
- **Q.7 — Why `requirements.txt` belongs at the root:** Placing the dependency file at the repository root makes it immediately visible to collaborators and automated setup tools so anyone can install the required external packages right away.
- **Q.8 — MCQ:** **A** (`.gitignore`)

## Part 3 — Organise Configuration, Data, and Documentation
- **Q.9, Q.10 & Q.11:** Executed via `github_project_structure_lab.sh` (`config.example.json` and `config.example.env` are tracked, while `.env` is ignored).
- **Q.12 — MCQ:** **C** (A configuration example containing field names but no secrets)

## Part 4 — Review and Version the Structure
- **Q.13 — Better locations for root files:**
  - `orders_2026_08_01.csv` -> `data/sample/orders_2026_08_01.csv`
  - `etl_notes.txt` -> `docs/etl_notes.txt`
  - `create_orders.sql` -> `sql/create_orders.sql`
  - `architecture.md` -> `docs/architecture.md`
- **Q.14 & Q.15:** Executed via `github_project_structure_lab.sh` using `.gitkeep` placeholders to preserve empty folders in Git.
- **Q.16 — MCQ:** **B** (`README.md`, `.gitignore`, and project entry files such as dependency information)

## Optional Practice
- **Q.17 — Reorganised messy repository:**
  - Root: `README.md`, `.gitignore`
  - `scripts/app.py`
  - `sql/final.sql`
  - `config/config.example.json`
  - `docs/notes.md`
  - `data/sample/data1.csv`, `data/sample/data2.csv`
  - `data/output/output.csv` (ignored via `.gitignore` if generated)
- **Q.18, Q.19 & Q.20:** Executed via `github_project_structure_lab.sh` (see `lab_output.txt`).
