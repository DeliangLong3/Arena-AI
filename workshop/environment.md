# Environment preparation

## Principles

The course must run in a clean, approved environment. Do not use a personal library with unknown versions and do not install `latest` during the live session.

## Required decisions before freeze

- approved R version;
- approved package mirror;
- package versions for `pharmaverseraw`, `pharmaversesdtm`, `pharmaverseadam`, `sdtm.oak`, `admiral`, `admiralonco`, `metacore`, `metatools`, `xportr`, `rtables`, `tern`, `rlistings`, `ggplot2`, `survival`, `targets`, `renv`, `yaml`, `digest`, `testthat`;
- whether the enterprise API may receive synthetic code/data and whether calls are retained;
- whether Quarto is installed or rendered in CI.

## Freeze procedure

```r
install.packages("renv")
renv::init(bare = TRUE)
# Install only the reviewed package set from the approved mirror.
renv::snapshot()
```

Commit `renv.lock` only after a reviewer checks repository URLs, package sources, versions and transitive dependencies. This repository does not fabricate a lockfile because the enterprise mirror has not been selected in this sandbox.

## Smoke test

```r
source("R/run_vendor_demo.R")
run_vendor_demo()
```

The expected evidence is listed in `docs/reproducibility.md`.
