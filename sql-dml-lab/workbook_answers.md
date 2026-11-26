# SQL Pre-Work — Lesson 3: SQL DML — Lab Answers
**Student:** Dakshayini M L

## MCQ Answers
- **Q.4 — DML Statement:** **B** — `INSERT`
- **Q.8 — Unsafe Update:** **A** — It can change many rows unintentionally
- **Q.12 — Delete vs Truncate:** **A** — `DELETE`
- **Q.16 — Rollback:** **B** — Reverses them

## Written & Workflow Answers
- **Q.11 — Parent Delete with Referential Integrity:** Attempting `DELETE FROM customers WHERE customer_id = 1` fails with a foreign-key constraint error because child rows in `orders` still reference `customer_id = 1`.
- **Q.15 — Transaction-Aware Workflow:**
  1. Preview target rows with `SELECT`.
  2. Start a transaction (`START TRANSACTION`).
  3. Run the `UPDATE` or `DELETE`.
  4. Verify affected rows with `SELECT`.
  5. Run `COMMIT` if accurate, or `ROLLBACK` if unexpected rows were affected.
- **Q.17 — Insert with Constraint Failure:** Inserting a second customer with `'amit@example.com'` fails because `email` has a `UNIQUE` constraint.
