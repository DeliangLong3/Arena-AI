# Synthetic vendor EDC export

These files are fixed, synthetic teaching fixtures. They are deliberately not CDISC-shaped and must be processed through the source contract before SDTM code sees them.

## Fixture rules

- `patient_id`, `exposure_id`, `event_id` and `assessment_id` are business/source keys;
- dates are ISO strings at the source boundary;
- treatment and response codes use vendor values;
- no PHI, PII or real study data is permitted;
- any fixture change must be made through `generate_vendor_export.R` and reviewed by diff.

## Controlled failure exercise

Make a copy outside the tracked fixture, change one `assessment_code` to `UNKNOWN` or duplicate an `event_id`, and confirm the contract check stops before SDTM generation.
