# Workshop materials

## Before the class

The instructor should complete these gates in an approved R environment:

1. install the package set from the enterprise mirror;
2. resolve and review `renv.lock`;
3. pin the upstream examples revision in `config/upstream.yml`;
4. run the official examples selected in `assets/upstream_examples.md`;
5. run the synthetic vendor path from clean state;
6. capture `reports/` evidence;
7. execute `python3 scripts/validate_skills.py`;
8. review the AI API data-retention and audit policy.

## Files

- `environment.md`: reproducible environment instructions;
- `instructor-guide.md`: timing, facilitation and failure injection;
- `participant-guide.md`: learner tasks and reflection questions;
- `assets/upstream_examples.md`: pinned official examples used in class;
- `assets/package-tour.R`: actual reference-data package tour;
- `slides-outline.md`: minimal slide structure.

## What runs live

- official `pharmaverse/examples` snippets for package orientation;
- this repository's source-contract and vendor-adapter exercise;
- a direct ADaM-to-TFL teaching path without ARS/ARD.

## What is shown as reference only

- full `sdtm.oak` domain recipes;
- full `admiralonco` RECIST/TTE recipes;
- `metacore`/`metatools` specification application;
- `xportr`/XPT and eSub;
- larger SDTM/ADaM domain coverage.
