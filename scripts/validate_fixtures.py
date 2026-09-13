#!/usr/bin/env python3
"""Validate the small synthetic vendor fixture without R dependencies."""
from pathlib import Path
import csv
import datetime as dt
import sys

ROOT = Path(__file__).resolve().parents[1] / "data-raw" / "vendor_export"
SCHEMA = {
    "patients.csv": ("patient_id", "patient_id,sex,age,race,randomization_date,treatment_code,itt_flag,safety_flag".split(",")),
    "exposure.csv": ("exposure_id", "patient_id,exposure_id,start_date,end_date,dose_mg,dose_unit,route".split(",")),
    "adverse_events.csv": ("event_id", "patient_id,event_id,term,soc,start_date,end_date,severity,related,serious,action".split(",")),
    "tumor_assessments.csv": ("assessment_id", "patient_id,assessment_id,assessment_date,visit,assessment_code,assessment_label".split(",")),
    "disposition.csv": ("patient_id", "patient_id,status,status_date,reason".split(",")),
}


def main():
    failures = []
    rows_by_file = {}
    for filename, (key, columns) in SCHEMA.items():
        path = ROOT / filename
        if not path.exists():
            failures.append(f"missing {path}")
            continue
        with path.open(newline="", encoding="utf-8") as handle:
            reader = csv.DictReader(handle)
            if reader.fieldnames != columns:
                failures.append(f"{filename}: header mismatch: {reader.fieldnames}")
            rows = list(reader)
        rows_by_file[filename] = rows
        keys = [(row.get(key), row.get("status_date")) if filename == "disposition.csv" else row.get(key) for row in rows]
        if len(keys) != len(set(keys)):
            failures.append(f"{filename}: duplicate key {key}")
        for row in rows:
            for field in [c for c in columns if c.endswith("date") or c.endswith("_date")]:
                value = row.get(field, "")
                if value:
                    try:
                        dt.date.fromisoformat(value)
                    except ValueError:
                        failures.append(f"{filename}: invalid ISO date {field}={value}")
    patients = {row["patient_id"] for row in rows_by_file.get("patients.csv", [])}
    for filename in ("exposure.csv", "adverse_events.csv", "tumor_assessments.csv", "disposition.csv"):
        for row in rows_by_file.get(filename, []):
            if row.get("patient_id") not in patients:
                failures.append(f"{filename}: unknown patient_id {row.get('patient_id')}")
    if failures:
        for failure in failures:
            print(f"FAIL {failure}")
        return 1
    print(f"Validated {len(SCHEMA)} synthetic vendor files")
    return 0


if __name__ == "__main__":
    sys.exit(main())
