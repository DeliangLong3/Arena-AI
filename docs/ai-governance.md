# AI governance for the workshop

## Purpose

AI reduces mechanical work and improves navigation of the R/pharmaverse ecosystem. It does not become a source of clinical truth or a validation authority.

## Allowed use

| Use | Required evidence |
| --- | --- |
| Explain an official example or function | link/file and the question asked |
| Profile synthetic vendor data | input hash and generated profile |
| Suggest source mapping | candidate mapping, uncertainty, reviewer decision |
| Generate test/documentation skeleton | Git diff and test result |
| Summarize pipeline failure | command, log, unchanged source and code |
| Prepare workshop narration | human review and final source link |

## Prohibited use

- sending PHI, PII, credentials, access tokens or proprietary live extracts;
- inventing or approving SAP, estimand, censoring, response or treatment rules;
- silently editing an approved mapping or derivation;
- suppressing warnings or changing a result to match an expectation;
- installing an unapproved package or calling an unapproved network endpoint;
- using AI at runtime to make an analysis decision.

## Enterprise API record

Each approved interaction should record, where the enterprise API makes it available:

- request ID;
- date/time and model identifier;
- skill name and skill revision;
- prompt/template hash;
- input artifact hashes;
- output artifact hash;
- human reviewer and decision;
- resulting Git commit or issue.

Do not store raw secrets or sensitive payloads in the repository. For this workshop, the data payload is synthetic by construction.

## Human gates

```text
AI suggestion
    ↓
statistician/programmer review
    ↓
Git diff + tests
    ↓
pipeline run + manifest
    ↓
workshop output
```

Any uncertainty in mapping or derivation stops the flow and becomes a review item.
