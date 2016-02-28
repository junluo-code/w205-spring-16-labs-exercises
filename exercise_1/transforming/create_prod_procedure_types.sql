DROP TABLE IF EXISTS prod.procedure_types;
CREATE TABLE prod.procedure_types
STORED AS ORC
AS
SELECT
procedure_id string,
procedure_type
FROM staging.procedure_types;