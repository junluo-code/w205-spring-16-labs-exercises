--procedure type: effective care = 1
--only include data that has valid score
DROP TABLE IF EXISTS prod.procedures;
CREATE TABLE prod.procedures
STORED AS ORC
AS
SELECT
provider_id,
measure_id,
null as compared_to_national,
null as denominator,
score,
null as lower_estimate,
null as higher_estimate,
footnote,
condition,
sample,
'1' as procedure_type
FROM staging.effective_care
WHERE ISNULL(CAST(score as INT)) == FALSE
UNION ALL
--procedure type: readmission and death = 2
--only include data that has valid score
SELECT
provider_id,
measure_id,
compared_to_national,
denominator,
score,
lower_estimate,
higher_estimate,
footnote,
null as condition,
null as sample,
'2' as procedure_type
FROM staging.readmissions
WHERE ISNULL(CAST(score as FLOAT)) == FALSE;
