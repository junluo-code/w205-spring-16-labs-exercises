SET hive.cli.print.header=true;

SELECT

m.measure_name Measure
,stddev(pctrank) stddev_pctrank

FROM (SELECT measure_id, percent_rank() OVER (partition by provider_id ORDER BY score) pctrank
          FROM prod.procedures) p
JOIN prod.measures m ON p.measure_id = m.measure_id

GROUP BY m.measure_name
ORDER BY stddev_pctrank DESC
LIMIT 10;
