# Git Pre-Work — Lesson 1: Version Control Basics — Lab Answers
**Student:** Dakshayini M L

## Part 1 — Why Version Control Is Useful
- **Q.1 & Q.2:** Executed via `version_control_lab.sh` (see `lab_output.txt`).
- **Q.3 — Problems with manual versioning (`pipeline_final_latest.py`):**
  1. It is difficult to know which file is the true working version.
  2. The reason and author for each edit are not recorded.
  3. Two teammates can accidentally edit separate copies and overwrite work.
- **Q.4 — MCQ:** **B** (To keep a history of changes and make versions easier to manage)

## Part 2 — Understand Project History
- **Q.5 — Useful change record details:** What changed, who made the change, when it changed, and why it changed.
- **Q.6 — Version history classification:**
  - SQL script: **Yes**
  - Project documentation: **Yes**
  - Small configuration template without secrets: **Yes**
  - Password: **No**
  - Large raw customer export: **Usually no**
- **Q.7:** Executed via `version_control_lab.sh` (`status=wrong` restored to `status=correct`).
- **Q.8 — MCQ:** **D** (Increase batch size from 100 to 500 for daily load)

## Part 3 — Working Alone and with Others
- **Q.9 — Collaboration risk:** Both teammates produce `sales_final.xlsx` with conflicting edits, making it unclear which version is valid, what changed, and risking one person's work overwriting the other's.
- **Q.10 — Matching:**
  - A -> local working copy idea
  - B -> shared repository idea
  - C -> saved version idea
  - D -> current unsaved change idea
- **Q.11 — When history helps:**
  - Query changed and now fails: **Yes**
  - Find who changed a configuration line: **Yes**
  - Compare two versions of a script: **Yes**
  - Forgot password for an unrelated website: **No**
- **Q.12 — MCQ:** **A** (Tracking and combining project changes made over time)

## Part 4 — Build Good Versioning Habits
- **Q.13:** `notes/design.txt` is an editable source/design file that requires controlled version history; `output/result.txt` is generated output that can be recreated.
- **Q.14 — Improved change descriptions:**
  - `change` -> `Add customer city column to daily sales report`
  - `fix file` -> `Fix incorrect order_date filter in ETL query`
  - `updated` -> `Update Linux setup instructions for Bash users`
- **Q.15 — Unsafe items to share:** `API password` and `Private SSH key`.
- **Q.16 — MCQ:** **C** (A private authentication key)

## Optional Practice
- **Q.17 — Timeline order:** New requirement arrives -> Report is changed -> Report is tested -> Working version is saved -> Problem is found later -> Earlier working version is inspected.
- **Q.18:** Executed via `version_control_lab.sh` (`environment` and `batch_size` changed).
- **Q.19 — Cleaner team workflow:** Keep a single clearly named file (`query.sql`) and use version control commits to track changes rather than adding names or `final` to filenames.
- **Q.20 — Version-control readiness checklist:**
  1. Which files are project source files?
  2. Which files are generated outputs?
  3. Does any file contain passwords, API keys, or private keys?
  4. Are filenames clear and stable without manual version tags?
  5. Which large raw datasets should remain outside version history?
