---
name: tfl-production
description: Builds and reviews direct ADaM-to-table, listing, and figure outputs using the approved TFL shell and classic rtables/tern approach. Use when creating or checking workshop TFLs after ADaM is approved; this skill does not create ARS or ARD.
---

# TFL production

## Scope

This workshop deliberately uses the classic direct ADaM-to-TFL path. The skill does not add an ARS/ARD layer and does not recompute a result behind an approved shell without recording the rule.

## Inputs

- approved ADaM dataset;
- TFL shell and output contract;
- population and treatment definitions;
- statistic, format, footnote and reviewer fields;
- official `rtables`/`tern` example when package APIs are used.

## Procedure

1. Confirm the shell identifies source dataset and population.
2. Confirm treatment order, denominator and statistic definitions.
3. Separate data preparation, analysis function and rendering.
4. Generate a table/listing/figure with deterministic ordering.
5. Save the input/output lineage and program version.
6. Compare structure and key counts with the expected snapshot.
7. Render only after the reviewer signs the content specification.

## Output contract

Return:

- output ID and type;
- input ADaM and filter;
- population/treatment/statistic definition;
- output artifact;
- key-count/snapshot result;
- footnote and format status;
- reviewer decision.

## Stop conditions

Stop when the shell is incomplete, when a denominator is implicit, when output code changes an analysis rule, when an ARS/ARD request enters this workshop, or when an output cannot be traced to ADaM.

## Example requests

- “Generate the TEAE table from the approved ADAE shell.”
- “Explain why this TFL changed after an ADAE mapping change.”
