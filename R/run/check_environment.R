# Environment checks -------------------------------------------------------

required_packages <- function() {
  c(
    "dplyr", "readr", "yaml", "digest", "ggplot2", "survival",
    "targets", "testthat"
  )
}

reference_packages <- function() {
  c(
    "pharmaverseraw", "pharmaversesdtm", "pharmaverseadam", "sdtm.oak",
    "admiral", "admiralonco", "metacore", "metatools", "rtables", "tern"
  )
}

check_environment <- function(include_reference = FALSE) {
  packages <- unique(c(required_packages(), if (include_reference) reference_packages()))
  status <- data.frame(
    package = packages,
    installed = vapply(packages, requireNamespace, logical(1), quietly = TRUE),
    version = vapply(packages, function(x) {
      if (!requireNamespace(x, quietly = TRUE)) return(NA_character_)
      as.character(utils::packageVersion(x))
    }, character(1)),
    stringsAsFactors = FALSE
  )
  status
}

stop_if_missing <- function(status) {
  missing <- status$package[!status$installed]
  if (length(missing) > 0) {
    stop("Missing approved packages: ", paste(missing, collapse = ", "), call. = FALSE)
  }
  invisible(status)
}
