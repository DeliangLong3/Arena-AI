# Official pharmaverse data tour ------------------------------------------
# Run only after the approved package set is installed. Dataset names below
# are taken from the pinned official examples revision in config/upstream.yml.

run_package_tour <- function() {
  required <- c("pharmaverseraw", "pharmaversesdtm", "pharmaverseadam")
  missing <- required[!vapply(required, requireNamespace, logical(1), quietly = TRUE)]
  if (length(missing) > 0) stop("Install approved reference packages: ", paste(missing, collapse = ", "), call. = FALSE)

  list(
    raw = list(
      dm_raw = pharmaverseraw::dm_raw,
      ds_raw = pharmaverseraw::ds_raw,
      ec_raw = pharmaverseraw::ec_raw
    ),
    sdtm = list(
      dm = pharmaversesdtm::dm,
      ae = pharmaversesdtm::ae,
      rs_onco_recist = pharmaversesdtm::rs_onco_recist
    ),
    adam = list(
      adsl = pharmaverseadam::adsl,
      adrs_onco = pharmaverseadam::adrs_onco
    )
  )
}

# Teaching discussion:
# - the official raw, SDTM and ADaM objects make the package chain visible;
# - sdtm.oak and admiral examples show how to construct them;
# - package test data is not a real study and not a sponsor specification.
