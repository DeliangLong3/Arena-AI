---
name: adam-derivation
description: Explains and scaffolds ADaM derivations using approved specifications and official admiral/admiralonco examples. Use when reviewing ADSL, ADAE, ADRS, or ADTTE logic, tracing a variable back to SDTM, or preparing a derivation test.
---

# ADaM derivation

## Purpose

Make the input, rule, output and test visible. The skill treats `admiral` as a modular toolbox and `admiralonco` as an oncology extension, not as a substitute for an SAP or ADaM specification.

## Inputs

- approved SDTM datasets;
- ADaM specification and metadata;
- SAP-derived analysis definitions;
- official package example at the pinned revision;
- expected population/treatment/event definitions.

## Procedure

1. State the dataset structure and record grain.
2. Identify required SDTM predecessors and ADSL joins.
3. Quote the approved derivation rule before suggesting code.
4. Prefer the official package idiom when the approved version supports it.
5. Create a focused test for normal, missing and boundary cases.
6. Produce variable-level lineage and unresolved questions.
7. Request human approval before any code is merged.

## Output contract

Return:

- dataset and variable;
- source variables/datasets;
- rule and assumptions;
- official example link/version;
- proposed implementation;
- test cases;
- lineage row;
- reviewer decision fields.

## Stop conditions

Stop when the SAP/specification does not define the rule, when event/censoring or response hierarchy is ambiguous, when a missing date requires an unapproved imputation, or when the package API cannot be verified.

## Human gate

The responsible statistician approves analysis meaning. The programmer approves implementation. Neither approval may be replaced by an AI confidence score.

## Example requests

- “Trace `ADTTE` PFS event back to `ADRS` and list the missing decisions.”
- “Draft tests for an ADSL population flag without choosing a new population.”
