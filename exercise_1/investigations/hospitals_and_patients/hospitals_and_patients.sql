SET hive.cli.print.header=true;

SELECT corr(avg_pctrank, hcahps_score) as quality_survey_correlation,
       corr(std_pctrank, hcahps_score) as variability_survey_correlation
FROM
(
SELECT provider_id, avg(hcahps_base_score+hcahps_consistency_score) as hcahps_score
FROM prod.surveys_responses
GROUP BY provider_id
) survey
LEFT JOIN
(
SELECT provider_id as provider_id, avg(pctrank) as avg_pctrank, stddev(pctrank) as std_pctrank
FROM (SELECT provider_id, percent_rank() OVER (partition by measure_id ORDER BY score) pctrank
      FROM prod.procedures) p
GROUP BY provider_id
) hospital
ON survey.provider_id = hospital.provider_id
;