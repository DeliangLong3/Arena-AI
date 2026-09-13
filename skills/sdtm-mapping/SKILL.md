---
name: sdtm-mapping
description: Explains and scaffolds source-to-SDTM mapping using the approved contract, metadata, and official sdtm.oak patterns. Use when reviewing a mapping specification, adapting a vendor EDC export, or teaching how source fields become SDTM domains.
---

# SDTM mapping

## Purpose

Separate vendor-specific ingestion from SDTM algorithms. The skill may draft a mapping candidate and a test; it may not claim CDISC conformance or approve controlled terminology.

## Inputs

- approved source-contract report;
- source-to-target mapping specification;
- study controlled terminology;
- official `sdtm.oak` documentation/example at the pinned revision;
- target domain and key definition.

## Procedure

1. Identify the source record grain and target domain class.
2. State the topic/key variables before mapping other fields.
3. Map source names to target names with an explicit transformation.
4. Identify controlled terminology, date/time and study-day rules.
5. Record assumptions and unresolved values.
6. Generate a reviewable code/test skeleton only.
7. Run domain checks after a human approves the mapping.

## Output contract

For each candidate mapping, return:

- source file/field;
- target domain/variable;
- transformation;
- terminology reference;
- key/record-grain statement;
- evidence URL or specification location;
- uncertainty;
- reviewer and decision.

## Stop conditions

Stop when the mapping requires an unstated clinical decision, an unknown code list, an ambiguous date, an unresolved duplicate, or an unsupported `sdtm.oak` API. Do not substitute an invented function name.

## Human gate

The mapping owner approves the specification. The programmer reviews generated code. The statistical reviewer resolves any treatment, response or analysis-relevant ambiguity.

## Example requests

- “Propose a candidate mapping for vendor `assessment_code` to RS.”
- “Explain the official DM `sdtm.oak` pattern without changing the mapping.”
