# SQL Pre-Work — Lesson 5: Aggregations — Lab Answers
**Student:** Dakshayini M L

## MCQ Answers
- **Q.4 — COUNT(*):** **B** — All rows in the result
- **Q.8 — Aggregate Function:** **A** — `MAX`
- **Q.12 — Result Grain:** **B** — One city group
- **Q.16 — HAVING Clause:** **B** — `HAVING`

## Written Answers
- **Q.15 — Compare WHERE and HAVING:**
  - `WHERE` filters individual source/detail rows before grouping and aggregation occur.
  - `HAVING` filters grouped/aggregated rows after `GROUP BY` has been evaluated.
- **Q.19 — Null Behaviour in `COUNT(*) vs COUNT(discount_amount)`:**
  - `COUNT(*)` returns `12` because it counts all rows in the table regardless of null values.
  - `COUNT(discount_amount)` returns `6` because `COUNT(column)` ignores rows where `discount_amount` is `NULL`.
