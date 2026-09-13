# Vendor adapter ------------------------------------------------------------
# Converts vendor-shaped records to a small, explicit workshop staging
# contract. This is the only module that knows vendor field names.

vendor_to_staging <- function(raw, study_id = "WS-ONCO-001") {
  if (!requireNamespace("dplyr", quietly = TRUE)) stop("dplyr is required.", call. = FALSE)
  treatment_label <- c(A = "Study Drug A", B = "Study Drug B")

  patients <- dplyr::transmute(
    raw$patients,
    STUDYID = study_id,
    USUBJID = paste(study_id, patient_id, sep = "-"),
    SUBJID = as.character(patient_id),
    RFSTDTC = as.character(randomization_date),
    SEX = as.character(sex),
    AGE = as.numeric(age),
    RACE = as.character(race),
    TRT01P = as.character(treatment_code),
    TRT01A = unname(treatment_label[as.character(treatment_code)]),
    ITTFL = as.character(itt_flag),
    SAFFL = as.character(safety_flag)
  )

  exposure <- dplyr::transmute(
    raw$exposure,
    STUDYID = study_id,
    USUBJID = paste(study_id, patient_id, sep = "-"),
    EXSPID = as.character(exposure_id),
    EXSTDTC = as.character(start_date),
    EXENDTC = as.character(end_date),
    EXDOSE = as.numeric(dose_mg),
    EXDOSU = as.character(dose_unit),
    EXROUTE = as.character(route)
  )

  adverse_events <- dplyr::transmute(
    raw$adverse_events,
    STUDYID = study_id,
    USUBJID = paste(study_id, patient_id, sep = "-"),
    AESPID = as.character(event_id),
    AETERM = as.character(term),
    AESOC = as.character(soc),
    AESTDTC = as.character(start_date),
    AEENDTC = as.character(end_date),
    AESEV_NUM = as.numeric(severity),
    AEREL = as.character(related),
    AESER = as.character(serious),
    AEACN = as.character(action)
  )

  tumor_assessments <- dplyr::transmute(
    raw$tumor_assessments,
    STUDYID = study_id,
    USUBJID = paste(study_id, patient_id, sep = "-"),
    RSSPID = as.character(assessment_id),
    RSDTC = as.character(assessment_date),
    VISIT = as.character(visit),
    RSORRES = as.character(assessment_code),
    RSORRES_LABEL = as.character(assessment_label)
  )

  disposition <- dplyr::transmute(
    raw$disposition,
    STUDYID = study_id,
    USUBJID = paste(study_id, patient_id, sep = "-"),
    DSSTDTC = as.character(status_date),
    DSDECOD = dplyr::if_else(status == "ONGOING", "ONGOING", as.character(reason)),
    DSSCAT = "DISPOSITION EVENT"
  )

  list(
    dm_staging = patients,
    ex_staging = exposure,
    ae_staging = adverse_events,
    rs_staging = tumor_assessments,
    ds_staging = disposition
  )
}
