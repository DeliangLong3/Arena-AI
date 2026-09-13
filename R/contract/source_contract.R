# Source contract validation -----------------------------------------------

read_source_contract <- function(path = "config/source-contract.yml") {
  if (!requireNamespace("yaml", quietly = TRUE)) stop("yaml is required.", call. = FALSE)
  yaml::read_yaml(path)
}

read_fixture <- function(path = "data-raw/vendor_export") {
  files <- c("patients.csv", "exposure.csv", "adverse_events.csv", "tumor_assessments.csv", "disposition.csv")
  paths <- file.path(path, files)
  if (!all(file.exists(paths))) {
    stop("Missing source fixture(s): ", paste(files[!file.exists(paths)], collapse = ", "), call. = FALSE)
  }
  setNames(lapply(paths, function(x) readr::read_csv(x, show_col_types = FALSE, na = c("", "NA"))), tools::file_path_sans_ext(files))
}

check_required_columns <- function(data, required, name) {
  missing <- setdiff(required, names(data))
  if (length(missing) > 0) stop(name, " is missing: ", paste(missing, collapse = ", "), call. = FALSE)
  invisible(TRUE)
}

check_unique_key <- function(data, key, name) {
  key_data <- data[, key, drop = FALSE]
  if (anyDuplicated(key_data)) stop(name, " has duplicate key: ", paste(key, collapse = ", "), call. = FALSE)
  invisible(TRUE)
}

check_controlled_values <- function(data, column, allowed, name) {
  observed <- unique(stats::na.omit(as.character(data[[column]])))
  invalid <- setdiff(observed, allowed)
  if (length(invalid) > 0) {
    stop(name, " has uncontrolled ", column, ": ", paste(invalid, collapse = ", "), call. = FALSE)
  }
  invisible(TRUE)
}

validate_source_contract <- function(raw, contract = read_source_contract()) {
  for (file_name in names(contract$files)) {
    object_name <- tools::file_path_sans_ext(file_name)
    spec <- contract$files[[file_name]]
    check_required_columns(raw[[object_name]], spec$required, object_name)
    check_unique_key(raw[[object_name]], spec$key, object_name)
  }
  values <- contract$controlled_values
  for (field in names(values)) {
    source_object <- switch(
      field,
      treatment_code = raw$patients,
      assessment_code = raw$tumor_assessments,
      severity = raw$adverse_events,
      related = raw$adverse_events,
      serious = raw$adverse_events,
      NULL
    )
    if (!is.null(source_object)) check_controlled_values(source_object, field, values[[field]], "source fixture")
  }
  invisible(TRUE)
}

profile_source <- function(raw) {
  do.call(rbind, lapply(names(raw), function(name) {
    data.frame(
      object = name,
      rows = nrow(raw[[name]]),
      columns = ncol(raw[[name]]),
      missing_values = sum(is.na(raw[[name]])),
      stringsAsFactors = FALSE
    )
  }))
}
