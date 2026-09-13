# Check the reference package set ------------------------------------------
# This does not silently install anything. It reports the approved package
# versions so the instructor can compare them with renv.lock and the official
# examples revision.

reference_package_versions <- function() {
  packages <- c("pharmaverseraw", "pharmaversesdtm", "pharmaverseadam", "sdtm.oak", "admiral", "admiralonco", "metacore", "metatools", "rtables", "tern")
  data.frame(
    package = packages,
    installed = vapply(packages, requireNamespace, logical(1), quietly = TRUE),
    version = vapply(packages, function(pkg) {
      if (!requireNamespace(pkg, quietly = TRUE)) return(NA_character_)
      as.character(utils::packageVersion(pkg))
    }, character(1)),
    stringsAsFactors = FALSE
  )
}
