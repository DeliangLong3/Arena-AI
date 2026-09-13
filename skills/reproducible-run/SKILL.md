---
name: reproducible-run
description: Runs the declared workshop pipeline and creates hashes, manifests, lineage, tests, and a clean-run summary. Use before rehearsal, after a source or package change, or when a result must be reproduced without relying on an AI conversation.
---

# Reproducible run

## Preconditions

- clean Git worktree or documented change;
- approved R/package environment and lockfile;
- source contract passed;
- no untracked live data or credentials;
- declared entry point (`targets` or `run_vendor_demo.R`).

## Procedure

1. Record Git commit, R version and package versions.
2. Hash the declared inputs and configuration.
3. Run the pipeline without changing code or installing packages.
4. Run contract, derivation and output checks.
5. Hash outputs and create lineage/manifest records.
6. Remove generated reports and repeat from clean state.
7. Compare key counts and output hashes.
8. Write a `PASS`, `REVIEW`, or `BLOCKED` decision with reviewer.

## Output contract

At minimum:

- `run_manifest.csv`;
- `lineage.csv`;
- test log;
- package/environment report;
- output snapshot comparison;
- review log.

## Stop conditions

Stop on lockfile mismatch, missing source hash, failed test, uncontrolled warning, output change without a declared input/code change, or runtime AI invocation.

## Human gate

The programmer owns execution evidence. The statistical reviewer owns interpretation of output differences. A successful process check does not approve statistical content.
