# Transparent teaching SDTM -----------------------------------------------
# This layer is deliberately small and inspectable. It demonstrates the
# source-contract boundary. For a real study, use reviewed sdtm.oak algorithms
# and study metadata; do not treat this as a conformance implementation.

build_sdtm_teaching <- function(staging) {
  dm <- staging$dm_staging |>
    dplyr::transmute(STUDYID, DOMAIN = "DM", USUBJID, SUBJID, RFSTDTC,
                     SEX, AGE, RACE, ARMCD = TRT01P, ARM = TRT01A)

  ex <- staging$ex_staging |>
    dplyr::group_by(USUBJID) |>
    dplyr::arrange(EXSTDTC, .by_group = TRUE) |>
    dplyr::mutate(EXSEQ = dplyr::row_number(), DOMAIN = "EX", EXTRT = "Study Drug", EXDOSFRM = "TABLET") |>
    dplyr::ungroup() |>
    dplyr::select(STUDYID, DOMAIN, USUBJID, EXSEQ, EXSPID, EXTRT, EXDOSE, EXDOSU, EXDOSFRM, EXROUTE, EXSTDTC, EXENDTC)

  ae <- staging$ae_staging |>
    dplyr::group_by(USUBJID) |>
    dplyr::arrange(AESTDTC, .by_group = TRUE) |>
    dplyr::mutate(
      AESEQ = dplyr::row_number(), DOMAIN = "AE", AEDECOD = AETERM,
      AESEV = dplyr::case_when(AESEV_NUM == 1 ~ "MILD", AESEV_NUM == 2 ~ "MODERATE", AESEV_NUM == 3 ~ "SEVERE", TRUE ~ NA_character_)
    ) |>
    dplyr::ungroup() |>
    dplyr::select(STUDYID, DOMAIN, USUBJID, AESEQ, AESPID, AETERM, AEDECOD, AESOC, AESTDTC, AEENDTC, AESEV, AEREL, AESER, AEACN)

  rs <- staging$rs_staging |>
    dplyr::group_by(USUBJID) |>
    dplyr::arrange(RSDTC, .by_group = TRUE) |>
    dplyr::mutate(RSSEQ = dplyr::row_number(), DOMAIN = "RS") |>
    dplyr::ungroup() |>
    dplyr::transmute(STUDYID, DOMAIN, USUBJID, RSSEQ, RSSPID,
                     RSTESTCD = "OVRLRESP", RSTEST = "Overall Response",
                     RSORRES, RSORRES_LABEL, RSDTC, VISIT)

  ds <- staging$ds_staging |>
    dplyr::group_by(USUBJID) |>
    dplyr::arrange(DSSTDTC, .by_group = TRUE) |>
    dplyr::mutate(DSSEQ = dplyr::row_number(), DOMAIN = "DS") |>
    dplyr::ungroup() |>
    dplyr::select(STUDYID, DOMAIN, USUBJID, DSSEQ, DSSCAT, DSDECOD, DSSTDTC)

  list(DM = dm, EX = ex, AE = ae, RS = rs, DS = ds)
}

validate_sdtm_teaching <- function(sdtm) {
  required <- list(
    DM = c("STUDYID", "DOMAIN", "USUBJID", "SUBJID"),
    EX = c("STUDYID", "DOMAIN", "USUBJID", "EXSEQ"),
    AE = c("STUDYID", "DOMAIN", "USUBJID", "AESEQ"),
    RS = c("STUDYID", "DOMAIN", "USUBJID", "RSSEQ", "RSORRES"),
    DS = c("STUDYID", "DOMAIN", "USUBJID", "DSSEQ")
  )
  for (domain in names(required)) {
    missing <- setdiff(required[[domain]], names(sdtm[[domain]]))
    if (length(missing) > 0) stop(domain, " missing: ", paste(missing, collapse = ", "), call. = FALSE)
    if (any(sdtm[[domain]]$DOMAIN != domain)) stop(domain, " has an incorrect DOMAIN value.", call. = FALSE)
  }
  invisible(TRUE)
}
