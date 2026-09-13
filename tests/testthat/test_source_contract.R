testthat::test_that("synthetic fixture has expected source files", {
  files <- c("patients.csv", "exposure.csv", "adverse_events.csv", "tumor_assessments.csv", "disposition.csv")
  testthat::expect_true(all(file.exists(file.path("data-raw/vendor_export", files))))
})

testthat::test_that("study scope excludes PK, ARS and SAS reference", {
  config <- yaml::read_yaml("config/study.yml")
  testthat::expect_false(config$study$include_pk)
  testthat::expect_false(config$study$include_ars)
  testthat::expect_false(config$study$include_sas_reference)
})

testthat::test_that("vendor adapter contract uses the declared target tables", {
  source("R/contract/source_contract.R")
  source_contract <- read_source_contract()
  testthat::expect_setequal(
    vapply(source_contract$files, function(x) x$target, character(1)),
    c("dm_staging", "ex_staging", "ae_staging", "rs_staging", "ds_staging")
  )
})
