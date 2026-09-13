# Instructor guide

## Teaching stance

The objective is understanding the pharmaverse composition and the R way of working, not typing every production line. Keep the official examples and the synthetic adapter visibly separate.

## Live sequence

1. Show the official package map and the pinned example revision.
2. Ask learners to identify the input, output, specification and check at each layer.
3. Run the source contract check before looking at derivations.
4. Run the vendor adapter and inspect its canonical staging output.
5. Run the transparent teaching SDTM/ADaM/TFL vertical slice.
6. Compare the source-specific adapter with the reusable downstream functions.
7. Run one controlled failure: duplicate `event_id` or invalid `assessment_code`.
8. Use an AI skill only to explain a file or propose a test; require human approval.
9. Delete `reports/`, rerun from clean state and inspect the manifest.

## Do not say

- “This is submission-ready.”
- “AI validated the data.”
- “The teaching PFS rule is a study SAP.”
- “One package replaces SAS or a statistician.”

## Do say

- “The official examples are the package API reference.”
- “This fixture demonstrates the contract boundary, not vendor certification.”
- “Open-source code is inspectable, versioned and testable.”
- “Study-specific rules remain owned by the responsible statistician.”
