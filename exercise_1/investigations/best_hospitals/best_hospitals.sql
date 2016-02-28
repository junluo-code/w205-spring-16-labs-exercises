SET hive.cli.print.header=true;

SELECT

h.hospital_name
,avg(pctrank) avg_pctrank
,stddev(pctrank) stddev_pctrank
,sum(pctrank) sum_pctrank

FROM (SELECT provider_id, percent_rank() OVER (partition by measure_id ORDER BY score) pctrank
          FROM prod.procedures) p
JOIN prod.hospitals h ON p.provider_id = h.provider_id

GROUP BY h.hospital_name
HAVING count(p.provider_id) >= 10
ORDER BY avg_pctrank DESC
LIMIT 10;
