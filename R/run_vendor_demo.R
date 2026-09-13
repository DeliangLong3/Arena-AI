# One-command vendor adapter vertical slice -------------------------------

source("R/run/check_environment.R")
source("R/contract/source_contract.R")
source("R/source/vendor_adapter.R")
source("R/sdtm/teaching_sdtm.R")
source("R/adam/teaching_adam.R")
source("R/tfl/direct_tfl.R")
source("R/run/run_manifest.R")

run_vendor_demo <- function(source_dir = "data-raw/vendor_export", output_dir = "reports") {
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
  raw <- read_fixture(source_dir)
  validate_source_contract(raw)
  readr::write_csv(profile_source(raw), file.path(output_dir, "source_profile.csv"))

  staging <- vendor_to_staging(raw)
  sdtm <- build_sdtm_teaching(staging)
  validate_sdtm_teaching(sdtm)
  dir.create(file.path(output_dir, "sdtm"), recursive = TRUE, showWarnings = FALSE)
  for (domain in names(sdtm)) readr::write_csv(sdtm[[domain]], file.path(output_dir, "sdtm", paste0(domain, ".csv")))

  adam <- build_adam_teaching(sdtm)
  validate_adam_teaching(adam)
  dir.create(file.path(output_dir, "adam"), recursive = TRUE, showWarnings = FALSE)
  for (dataset in names(adam)) readr::write_csv(adam[[dataset]], file.path(output_dir, "adam", paste0(dataset, ".csv")))

  tfl <- build_tfl_teaching(adam)
  dir.create(file.path(output_dir, "tfl"), recursive = TRUE, showWarnings = FALSE)
  for (output in names(tfl)) readr::write_csv(tfl[[output]], file.path(output_dir, "tfl", paste0(output, ".csv")))
  plot_pfs_teaching(adam, file.path(output_dir, "F_PFS_KM.png"))

  input_paths <- list.files(source_dir, pattern = "\\.csv$", full.names = TRUE)
  output_paths <- list.files(output_dir, recursive = TRUE, full.names = TRUE)
  write_lineage(data.frame(
    source = c("patients.csv", "adverse_events.csv", "tumor_assessments.csv", "disposition.csv"),
    target = c("DM/ADSL", "AE/ADAE", "RS/ADRS", "DS/ADTTE"),
    rule = c("vendor adapter + DM mapping", "vendor adapter + AE mapping", "vendor adapter + response mapping", "vendor adapter + event/censoring teaching rule"),
    reviewer = NA_character_,
    stringsAsFactors = FALSE
  ), path = file.path(output_dir, "lineage.csv"))
  output_paths <- list.files(output_dir, recursive = TRUE, full.names = TRUE)
  write_manifest(input_paths, output_paths, path = file.path(output_dir, "run_manifest.csv"))
  message("Vendor teaching path completed. Review reports/ before using the output in class.")
  invisible(list(raw = raw, staging = staging, sdtm = sdtm, adam = adam, tfl = tfl))
}
