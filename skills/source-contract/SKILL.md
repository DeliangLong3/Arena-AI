---
name: source-contract
description: Profiles and validates the synthetic vendor EDC export against the versioned source contract before SDTM work begins. Use when a new fixture arrives, a vendor schema changes, or the pipeline must fail early on missing fields, duplicate keys, or uncontrolled values.
---

# Source contract

## Purpose

Protect the standardization layer from unreviewed source changes. The skill reads source metadata and creates evidence; it never changes the fixture or approves a mapping.

## Preconditions

- source files are synthetic or explicitly approved;
- `config/source-contract.yml` is available;
- the input directory is read-only for this task;
- credentials and live extracts are absent.

## Procedure

1. Enumerate only the files declared in the contract.
2. Record file size, row count, columns and SHA-256.
3. Check required columns and data types.
4. Check declared keys for duplicates and missing values.
5. Check controlled values and ISO date format.
6. Produce a review queue for every deviation.
7. Stop before SDTM if any blocking check fails.

## Output contract

Write:

- `source_profile.csv`;
- `contract_findings.csv`;
- `input_manifest.csv`;
- a clear `PASS`, `REVIEW`, or `BLOCKED` status.

## Stop conditions

The skill must return `BLOCKED` when a required field, key, value set, file or hash is invalid. It must not repair values, infer clinical meaning, or continue with warnings hidden.

## Human gate

The data manager or responsible programmer reviews source findings. The statistician approves any mapping that influences treatment, response, event or censoring variables.

## Example requests

- “Profile the new vendor export without modifying it.”
- “Tell me why the source contract blocked SDTM generation.”
