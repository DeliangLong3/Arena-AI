---
name: reference-data
description: Locates and verifies the pinned pharmaverse raw, SDTM, and ADaM reference examples for the workshop. Use when preparing the environment, explaining package interoperability, or checking whether an example is an official upstream source.
---

# Reference data

## Purpose

Keep official pharmaverse examples separate from the repository's synthetic vendor fixture. The skill reports package and upstream revision information; it does not silently install packages or rewrite examples.

## Inputs

- `config/upstream.yml`;
- `config/package-selection.yml`;
- the approved R package library;
- the official examples website or pinned repository checkout.

## Procedure

1. Read the requested package, example path and revision from configuration.
2. Confirm that the checkout or website matches the recorded revision.
3. Check whether the requested package is installed and report its version.
4. Open the official example before describing an API.
5. Report the source URL and revision with any code explanation.
6. Keep PK examples out of the live workshop path.

## Output contract

Return a structured report containing:

- package or repository;
- requested revision;
- observed revision/version;
- source URL;
- availability status;
- unresolved differences;
- human reviewer field.

## Stop conditions

Stop without installing or editing when:

- the revision cannot be verified;
- the requested API is not present in the approved version;
- the user asks to treat a test dataset as real study data;
- the requested example is PK-specific for this workshop;
- the package source is not approved.

## Human gate

A workshop owner approves the package/version matrix before the lesson is rehearsed. A statistician or programmer checks that the official example supports the teaching claim.

## Example requests

- “Locate the official ADRS example used in today’s lesson.”
- “Report whether the approved `admiral` version contains the function in this slide.”
