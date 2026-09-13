# Run evidence -------------------------------------------------------------

sha256_file <- function(path) {
  if (!requireNamespace("digest", quietly = TRUE)) stop("digest is required.", call. = FALSE)
  if (!file.exists(path)) return(NA_character_)
  digest::digest(file = path, algo = "sha256")
}

write_manifest <- function(input_paths, output_paths, path = "reports/run_manifest.csv") {
  dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)
  all_paths <- c(input_paths, output_paths)
  manifest <- data.frame(
    artifact_type = c(rep("input", length(input_paths)), rep("output", length(output_paths))),
    path = normalizePath(all_paths, winslash = "/", mustWork = FALSE),
    sha256 = vapply(all_paths, sha256_file, character(1)),
    git_commit = Sys.getenv("GIT_COMMIT", "unknown"),
    run_time_utc = format(Sys.time(), tz = "UTC", usetz = TRUE),
    stringsAsFactors = FALSE
  )
  readr::write_csv(manifest, path)
  invisible(manifest)
}

write_lineage <- function(rows, path = "reports/lineage.csv") {
  dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)
  readr::write_csv(rows, path)
  invisible(rows)
}
