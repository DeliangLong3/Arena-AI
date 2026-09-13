# Transparent teaching ADaM -----------------------------------------------
# These functions are a workshop bridge. The official admiral/admiralonco
# examples are the package API reference and must be used for production work.

build_adam_teaching <- function(sdtm) {
  ex_dates <- sdtm$EX |>
    dplyr::group_by(USUBJID) |>
    dplyr::summarise(TRTSDT = min(as.Date(EXSTDTC)), TRTEDT = max(as.Date(EXENDTC)), .groups = "drop")

  adsl <- sdtm$DM |>
    dplyr::left_join(ex_dates, by = "USUBJID") |>
    dplyr::transmute(STUDYID, USUBJID, SUBJID, TRT01P = ARMCD, TRT01A = ARM,
                     SEX, AGE, RACE, RFSTDTC, TRTSDT, TRTEDT,
                     ITTFL = "Y", SAFFL = "Y")

  adae <- sdtm$AE |>
    dplyr::left_join(adsl |> dplyr::select(USUBJID, TRT01P, TRT01A, RFSTDTC), by = "USUBJID") |>
    dplyr::mutate(AESTDT = as.Date(AESTDTC), TRTEMFL = dplyr::if_else(AESTDT >= as.Date(RFSTDTC), "Y", "N"))

  response_rank <- c(CR = 1L, PR = 2L, SD = 3L, PD = 4L)
  adrs <- sdtm$RS |>
    dplyr::mutate(RESPONSE_RANK = unname(response_rank[RSORRES])) |>
    dplyr::group_by(USUBJID) |>
    dplyr::arrange(RESPONSE_RANK, RSDTC, .by_group = TRUE) |>
    dplyr::slice_head(n = 1) |>
    dplyr::ungroup() |>
    dplyr::transmute(STUDYID, USUBJID, PARAMCD = "BOR", PARAM = "Best Overall Response",
                     BOR = RSORRES, BORDT = as.Date(RSDTC), ORRFL = dplyr::if_else(RSORRES %in% c("CR", "PR"), "Y", "N")) |>
    dplyr::left_join(adsl |> dplyr::select(USUBJID, TRT01P, TRT01A, ITTFL), by = "USUBJID")

  last_disposition <- sdtm$DS |>
    dplyr::group_by(USUBJID) |>
    dplyr::summarise(LASTDT = max(as.Date(DSSTDTC)), .groups = "drop")

  adtte <- adrs |>
    dplyr::left_join(adsl |> dplyr::select(USUBJID, RFSTDTC), by = "USUBJID") |>
    dplyr::left_join(last_disposition, by = "USUBJID") |>
    dplyr::mutate(
      PARAMCD = "PFS", PARAM = "Progression-Free Survival",
      PFS_EVENT = as.integer(BOR == "PD"), CNSR = 1L - PFS_EVENT,
      ADT = dplyr::if_else(PFS_EVENT == 1L, BORDT, LASTDT),
      AVAL = as.numeric(ADT - as.Date(RFSTDTC)) + 1
    ) |>
    dplyr::select(STUDYID, USUBJID, PARAMCD, PARAM, TRT01P, TRT01A,
                  BOR, BORDT, PFS_EVENT, CNSR, ADT, AVAL)

  list(ADSL = adsl, ADAE = adae, ADRS = adrs, ADTTE = adtte)
}

validate_adam_teaching <- function(adam) {
  if (anyDuplicated(adam$ADSL$USUBJID)) stop("ADSL is not one record per subject.", call. = FALSE)
  if (!all(adam$ADRS$BOR %in% c("CR", "PR", "SD", "PD"))) stop("Unexpected BOR.", call. = FALSE)
  if (!all(adam$ADTTE$CNSR %in% c(0L, 1L))) stop("Invalid censoring flag.", call. = FALSE)
  invisible(TRUE)
}
