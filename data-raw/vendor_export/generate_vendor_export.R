# Generate the complete synthetic vendor fixture --------------------------
# Base R only, deterministic, and contains no real patient information.

set.seed(20260912)
out <- "data-raw/vendor_export"
dir.create(out, recursive = TRUE, showWarnings = FALSE)

write_fixture <- function(x, name) {
  utils::write.csv(x, file.path(out, name), row.names = FALSE, na = "")
}

write_fixture(data.frame(
  patient_id = 101:108,
  sex = c("M", "F", "M", "F", "M", "F", "M", "F"),
  age = c(58, 64, 49, 61, 55, 47, 68, 59),
  race = c("ASIAN", "WHITE", "WHITE", "BLACK", "WHITE", "ASIAN", "WHITE", "BLACK"),
  randomization_date = c("2025-01-05", "2025-01-07", "2025-01-12", "2025-01-15", "2025-01-06", "2025-01-09", "2025-01-14", "2025-01-18"),
  treatment_code = c("A", "A", "A", "A", "B", "B", "B", "B"),
  itt_flag = "Y", safety_flag = "Y"
), "patients.csv")

write_fixture(data.frame(
  patient_id = 101:108,
  exposure_id = paste0("EX-", 101:108, "-1"),
  start_date = c("2025-01-05", "2025-01-07", "2025-01-12", "2025-01-15", "2025-01-06", "2025-01-09", "2025-01-14", "2025-01-18"),
  end_date = c("2025-03-30", "2025-04-10", "2025-02-16", "2025-04-20", "2025-03-10", "2025-04-15", "2025-03-25", "2025-02-28"),
  dose_mg = 200, dose_unit = "mg", route = "ORAL"
), "exposure.csv")

write_fixture(data.frame(
  patient_id = c(101, 101, 102, 103, 104, 105, 105, 106, 107, 108),
  event_id = paste0("AE-", 1:10),
  term = c("Nausea", "Fatigue", "Rash", "Neutropenia", "Headache", "Fatigue", "Diarrhoea", "Nausea", "Anemia", "Pyrexia"),
  soc = c("GASTROINTESTINAL DISORDERS", "GENERAL DISORDERS AND ADMINISTRATION SITE CONDITIONS", "SKIN AND SUBCUTANEOUS TISSUE DISORDERS", "BLOOD AND LYMPHATIC SYSTEM DISORDERS", "NERVOUS SYSTEM DISORDERS", "GENERAL DISORDERS AND ADMINISTRATION SITE CONDITIONS", "GASTROINTESTINAL DISORDERS", "GASTROINTESTINAL DISORDERS", "BLOOD AND LYMPHATIC SYSTEM DISORDERS", "GENERAL DISORDERS AND ADMINISTRATION SITE CONDITIONS"),
  start_date = c("2025-01-10", "2025-02-02", "2025-01-20", "2025-01-20", "2025-02-01", "2025-01-15", "2025-02-04", "2025-01-13", "2025-02-01", "2025-01-25"),
  end_date = c("2025-01-12", "2025-02-08", "2025-01-28", "2025-01-25", "2025-02-02", "2025-01-21", "2025-02-09", "2025-01-17", "2025-02-20", "2025-01-27"),
  severity = c(2, 1, 2, 3, 1, 2, 2, 1, 2, 2),
  related = c("Y", "N", "Y", "Y", "N", "Y", "Y", "Y", "N", "Y"),
  serious = c("N", "N", "N", "Y", "N", "N", "N", "N", "N", "N"),
  action = c("NONE", "NONE", "DOSE REDUCED", "DOSE INTERRUPTED", "NONE", "NONE", "NONE", "NONE", "NONE", "NONE")
), "adverse_events.csv")

write_fixture(data.frame(
  patient_id = c(101, 101, 102, 102, 103, 104, 104, 105, 106, 106, 107, 108),
  assessment_id = paste0("RS-", 1:12),
  assessment_date = c("2025-02-02", "2025-03-02", "2025-02-04", "2025-03-04", "2025-02-09", "2025-02-12", "2025-03-12", "2025-02-03", "2025-02-06", "2025-03-06", "2025-02-11", "2025-02-15"),
  visit = c("WEEK 4", "WEEK 8", "WEEK 4", "WEEK 8", "WEEK 4", "WEEK 4", "WEEK 8", "WEEK 4", "WEEK 4", "WEEK 8", "WEEK 4", "WEEK 4"),
  assessment_code = c("PR", "PR", "SD", "SD", "PD", "CR", "CR", "PD", "PR", "PR", "SD", "PD"),
  assessment_label = c("Partial Response", "Partial Response", "Stable Disease", "Stable Disease", "Progressive Disease", "Complete Response", "Complete Response", "Progressive Disease", "Partial Response", "Partial Response", "Stable Disease", "Progressive Disease")
), "tumor_assessments.csv")

write_fixture(data.frame(
  patient_id = 101:108,
  status = c("ONGOING", "ONGOING", "DISCONTINUED", "ONGOING", "DISCONTINUED", "ONGOING", "DISCONTINUED", "DISCONTINUED"),
  status_date = c("2025-03-30", "2025-04-10", "2025-02-16", "2025-04-20", "2025-03-10", "2025-04-15", "2025-03-25", "2025-02-28"),
  reason = c(NA, NA, "PROGRESSIVE DISEASE", NA, "PROGRESSIVE DISEASE", NA, "ADVERSE EVENT", "PROGRESSIVE DISEASE")
), "disposition.csv")

message("Wrote deterministic synthetic vendor export to ", out)
