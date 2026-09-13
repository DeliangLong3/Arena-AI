# Reproducibility and evidence

## Required controls

1. **Environment** — company-approved R version, package mirror and `renv.lock`;
2. **Inputs** — immutable or hash-recorded synthetic fixtures;
3. **Configuration** — study, source contract and TFL specification under Git;
4. **Execution** — `targets` or a documented deterministic entry point;
5. **Checks** — schema, key, terminology, expected-count and output checks;
6. **Lineage** — source field → SDTM variable → ADaM variable → TFL input;
7. **Run evidence** — Git commit, input/output hashes, command, timestamp and status;
8. **Review** — reviewer, issue/diff and disposition for every exception.

## What the workshop demonstrates

- reproducible engineering controls;
- how to separate vendor-specific ingestion from reusable downstream logic;
- how to inspect the actual source code of open-source packages;
- how to use AI without making it a hidden dependency.

## What it does not demonstrate

- sponsor-specific validation plans;
- full SDTM/ADaM conformance for a real study;
- regulatory acceptance;
- statistical equivalence to SAS;
- a final submission package.

## Minimum evidence bundle

```text
run_manifest.csv
source_profile.csv
sdtm_checks.csv
adam_checks.csv
tfl_snapshot.csv
lineage.csv
ai_interaction_index.csv
review_log.csv
```
