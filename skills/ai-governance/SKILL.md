---
name: ai-governance
description: Governs enterprise-API assistance for the workshop so AI handles explanation and mechanical scaffolding without receiving live clinical data or making clinical decisions. Use whenever an AI agent profiles data, proposes mappings, edits code, summarizes failures, or records an interaction.
---

# AI governance

## Default posture

Treat every AI response as an untrusted suggestion. Runtime analysis must remain deterministic and must not call the AI API.

## Before invocation

1. Classify the input as synthetic, approved code/metadata, or prohibited live data.
2. Remove PHI, PII, credentials, tokens and connection strings.
3. Select the narrowest skill and attach only the required files.
4. Record the skill revision and input hashes.

## After invocation

1. Save only approved audit metadata, not secrets or restricted payloads.
2. Review the response against the official package documentation or project specification.
3. Put accepted code/metadata into a Git diff.
4. Run tests and the reproducible pipeline.
5. Record human reviewer, decision and unresolved uncertainty.

## Allowed

- explain official examples;
- profile synthetic data;
- propose mapping candidates;
- scaffold tests/documentation;
- summarize errors and changed artifacts.

## Forbidden

- choose or modify an SAP, estimand, response hierarchy, treatment, event or censoring rule;
- approve a mapping or waive an error;
- upload live clinical data or secrets;
- install packages or call unapproved endpoints;
- hide an AI-generated change;
- claim that an AI response is validation evidence.

## Output contract

Return an interaction record containing:

- skill name and revision;
- input artifact classifications and hashes;
- request ID/model identifier when available;
- proposed action or explanation;
- human reviewer and decision;
- Git change and test/pipeline evidence;
- unresolved uncertainty.

Never write raw credentials, live clinical records or restricted prompt payloads to the repository.

## Stop conditions

Stop and request human review when data classification is unclear, the prompt asks for a clinical decision, the source contract is blocked, or the requested package behavior cannot be verified.
