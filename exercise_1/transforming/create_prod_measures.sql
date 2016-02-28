DROP TABLE IF EXISTS prod.measures;
CREATE TABLE prod.measures
STORED AS ORC
AS
SELECT
measure_name, 
measure_id, 
measure_start_quarter, 
measure_start_date, 
measure_end_quarter, 
measure_end_date
FROM staging.measures;