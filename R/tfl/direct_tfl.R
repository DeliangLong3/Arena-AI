# Direct ADaM-to-TFL teaching path -----------------------------------------
# This is the selected classic path because ARS/ARD is out of scope.

build_tfl_teaching <- function(adam) {
  demographics <- adam$ADSL |>
    dplyr::count(TRT01P, SEX, name = "N") |>
    dplyr::arrange(TRT01P, SEX)

  teae <- adam$ADAE |>
    dplyr::filter(TRTEMFL == "Y") |>
    dplyr::distinct(USUBJID, TRT01P, AESOC, AEDECOD) |>
    dplyr::count(TRT01P, AESOC, AEDECOD, name = "N") |>
    dplyr::arrange(TRT01P, AESOC, AEDECOD)

  bor <- adam$ADRS |>
    dplyr::count(TRT01P, BOR, name = "N") |>
    dplyr::group_by(TRT01P) |>
    dplyr::mutate(DENOM = sum(N), PCT = round(100 * N / DENOM, 1)) |>
    dplyr::ungroup()

  pfs <- adam$ADTTE |>
    dplyr::group_by(TRT01P) |>
    dplyr::summarise(N = dplyr::n(), EVENTS = sum(PFS_EVENT), .groups = "drop")

  ae_listing <- adam$ADAE |>
    dplyr::filter(TRTEMFL == "Y") |>
    dplyr::select(USUBJID, TRT01P, AEDECOD, AESTDTC, AESEV, AESER, AEREL, AEACN) |>
    dplyr::arrange(TRT01P, USUBJID, AESTDTC)

  list(T_DEMOG = demographics, T_TEAE = teae, T_BOR = bor, T_PFS = pfs, L_AE = ae_listing)
}

plot_pfs_teaching <- function(adam, path = "reports/F_PFS_KM.png") {
  if (!requireNamespace("ggplot2", quietly = TRUE)) stop("ggplot2 is required.", call. = FALSE)
  if (!requireNamespace("survival", quietly = TRUE)) stop("survival is required.", call. = FALSE)
  fit <- survival::survfit(survival::Surv(AVAL, PFS_EVENT) ~ TRT01P, data = adam$ADTTE)
  plot_data <- data.frame(time = fit$time, survival = fit$surv, strata = rep(names(fit$strata), fit$strata))
  p <- ggplot2::ggplot(plot_data, ggplot2::aes(time, survival, colour = strata)) +
    ggplot2::geom_step() +
    ggplot2::labs(x = "Days from randomization", y = "Progression-free probability", colour = "Treatment") +
    ggplot2::theme_minimal()
  dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)
  ggplot2::ggsave(path, p, width = 7, height = 5, dpi = 150)
  path
}
