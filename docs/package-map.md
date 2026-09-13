# Pharmaverse package map

本表用于课堂导览，不是企业 package approval list。版本和能力应以课程冻结时的官方文档为准。

| Pipeline stage | Package/resource | Why it is shown | Official reference |
| --- | --- | --- | --- |
| Raw reference | `pharmaverseraw` | consistent raw test data | <https://pharmaverse.github.io/pharmaverseraw/> |
| SDTM reference | `pharmaversesdtm` | generated SDTM test data | <https://pharmaverse.github.io/pharmaversesdtm/> |
| SDTM mapping | `sdtm.oak` | EDC/data-standard agnostic, algorithm-based SDTM mapping | <https://pharmaverse.github.io/sdtm.oak/> |
| ADaM core | `admiral` | modular ADaM derivations | <https://pharmaverse.github.io/admiral/> |
| Oncology ADaM | `admiralonco` | oncology response and TTE extensions | <https://pharmaverse.github.io/admiralonco/> |
| Metadata | `metacore`, `metatools` | specification object, checks and metadata application | <https://atorus-research.github.io/metacore/> · <https://pharmaverse.github.io/metatools/> |
| Transport | `xportr` | XPT metadata and export; optional in this one-day path | <https://atorus-research.github.io/xportr/> |
| TFL classic path | `rtables`, `tern` | direct ADaM → table approach; selected because ARS is out of scope | <https://insightsengineering.github.io/rtables/> · <https://insightsengineering.github.io/tern/> |
| Listing/graphics | `rlistings`, `ggplot2`, `ggsurvfit` | listing and survival visualization | package documentation |
| Reproducibility | `renv`, `targets`, Quarto, Git | environment and run-level control | enterprise tooling policy |

## Recommended official reading order

1. [pharmaverse examples](https://pharmaverse.github.io/examples/)
2. [SDTM examples](https://pharmaverse.github.io/examples/sdtm/)
3. [ADSL example](https://pharmaverse.github.io/examples/adam/adsl.html)
4. [ADRS example](https://pharmaverse.github.io/examples/adam/adrs.html)
5. [ADTTE example](https://pharmaverse.github.io/examples/adam/adtte.html)
6. [TLG examples](https://pharmaverse.github.io/examples/tlg/)

## Teaching caveat

`pharmaverseraw`/`pharmaversesdtm`/`pharmaverseadam` are reference/test data resources. They should not be described as a company's study data or as a substitute for study-specific metadata. The workshop uses them to teach package interoperability; the synthetic vendor export teaches source adaptation.
