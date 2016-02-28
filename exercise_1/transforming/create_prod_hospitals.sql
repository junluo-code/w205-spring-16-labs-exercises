DROP TABLE IF EXISTS prod.hospitals;
CREATE TABLE prod.hospitals
STORED AS ORC
AS
SELECT
provider_id,
hospital_name,
address,
city,
state,
zip_code,
county_name,
phone_number,
hospital_type,
hospital_ownership,
emergency_services
FROM staging.hospitals;