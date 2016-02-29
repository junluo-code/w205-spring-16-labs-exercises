Steps to run exercise_1:

1.	Mount EBS volume
mount -t ext4 /dev/xvdf /data

2.	Start Hadoop
/root/start-hadoop.sh

3.	Start Postgres
/data/start_postgres.sh

4.	Run as user w205

su – w205

5.	Download dataset and load them into HDFS
Change directory into  /loading_and_modelling

bash load_data_lake.sh

6.	Create base tables in Hive
Change directory into  /loading_and_modelling

hive –f  hive_base_ddl.sql

7.	Transform and load data into prod database and tables:
Change directory into /transforming

hive -f create_prod_hospitals.sql
hive -f create_prod_measures.sql
hive -f create_prod_procedure_types.sql
hive -f create_prod_procedures.sql
hive -f create_prod_surveys_responses.sql

8.	Run investigation scripts
Change directory into /investigations/best_hospitals
hive -f best_hospitals.sql

Change directory into /investigations/best_states
hive -f best_states.sql

Change directory into /investigations/hospital_variability
hive -f hospital_variability.sql

Change directory into /investigations/hospitals_and_patients
hive -f hospitals_and_patients.sql
