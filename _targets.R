# Reproducible targets pipeline -------------------------------------------

library(targets)
source("R/run/check_environment.R")
source("R/contract/source_contract.R")
source("R/source/vendor_adapter.R")
source("R/sdtm/teaching_sdtm.R")
source("R/adam/teaching_adam.R")
source("R/tfl/direct_tfl.R")
source("R/run/run_manifest.R")

tar_option_set(
  packages = c("dplyr", "readr", "yaml", "digest", "ggplot2", "survival"),
  seed = 20260912,
  format = "rds"
)

list(
  tar_target(source_files, list.files("data-raw/vendor_export", pattern = "\\.csv$", full.names = TRUE), format = "file"),
  tar_target(raw, { source_files; read_fixture("data-raw/vendor_export") }),
  tar_target(source_profile, { validate_source_contract(raw); profile_source(raw) }),
  tar_target(source_profile_file, {
    dir.create("reports", recursive = TRUE, showWarnings = FALSE)
    readr::write_csv(source_profile, "reports/source_profile.csv")
    "reports/source_profile.csv"
  }, format = "file"),
  tar_target(staging, vendor_to_staging(raw)),
  tar_target(sdtm, { result <- build_sdtm_teaching(staging); validate_sdtm_teaching(result); result }),
  tar_target(sdtm_files, {
    dir.create("reports/sdtm", recursive = TRUE, showWarnings = FALSE)
    paths <- file.path("reports/sdtm", paste0(names(sdtm), ".csv"))
    Map(readr::write_csv, sdtm, paths)
    paths
  }, format = "file"),
  tar_target(adam, { result <- build_adam_teaching(sdtm); validate_adam_teaching(result); result }),
  tar_target(adam_files, {
    dir.create("reports/adam", recursive = TRUE, showWarnings = FALSE)
    paths <- file.path("reports/adam", paste0(names(adam), ".csv"))
    Map(readr::write_csv, adam, paths)
    paths
  }, format = "file"),
  tar_target(tfl, build_tfl_teaching(adam)),
  tar_target(tfl_files, {
    dir.create("reports/tfl", recursive = TRUE, showWarnings = FALSE)
    paths <- file.path("reports/tfl", paste0(names(tfl), ".csv"))
    Map(readr::write_csv, tfl, paths)
    paths
  }, format = "file"),
  tar_target(figure_file, plot_pfs_teaching(adam, "reports/F_PFS_KM.png"), format = "file"),
  tar_target(lineage_file, {
    write_lineage(data.frame(
      source = c("patients.csv", "adverse_events.csv", "tumor_assessments.csv", "disposition.csv"),
      target = c("DM/ADSL", "AE/ADAE", "RS/ADRS", "DS/ADTTE"),
      rule = c("vendor adapter + DM mapping", "vendor adapter + AE mapping", "vendor adapter + response mapping", "vendor adapter + teaching TTE rule"),
      reviewer = NA_character_,
      stringsAsFactors = FALSE
    ), "reports/lineage.csv")
    "reports/lineage.csv"
  }, format = "file"),
  tar_target(manifest_file, {
    write_manifest(source_files, c(source_profile_file, sdtm_files, adam_files, tfl_files, figure_file, lineage_file), "reports/run_manifest.csv")
    "reports/run_manifest.csv"
  }, format = "file")
)
