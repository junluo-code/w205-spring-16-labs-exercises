#!/bin/bash

#start from w205 home directory
cd /home/w205

#clean up exercise 1 folder and set up staging folder
rm -r -f exercise_1
mkdir exercise_1
cd exercise_1

#download dataset
wget -O dataset.zip "https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip"

#unzip dataset zip file
echo | unzip dataset.zip

#rename base files
mkdir staging
mv "Hospital General Information.csv" staging/hospitals.csv
mv "Measure Dates.csv" staging/measures.csv
mv "Timely and Effective Care - Hospital.csv" staging/effective_care.csv
mv "Readmissions and Deaths - Hospital.csv" staging/readmissions.csv
mv "hvbp_hcahps_05_28_2015.csv" staging/surveys_responses.csv

#strip the first line of a file
cd staging
tail -n+2 hospitals.csv > hospitals_stripped.csv
tail -n+2 measures.csv > measures_stripped.csv
tail -n+2 effective_care.csv > effective_care_stripped.csv
tail -n+2 readmissions.csv > readmissions_stripped.csv
tail -n+2 surveys_responses.csv > surveys_responses_stripped.csv

#create data file for procedure types
echo "1, Effective Care" >> procedure_types.csv
echo "2, Readmissions and Deaths" >> procedure_types.csv

#clean up HDFS directories
hdfs dfs -rm -r -f /user/w205/exercise_1
hdfs dfs -mkdir /user/w205/exercise_1

#move data files into HDFS
hdfs dfs -mkdir /user/w205/exercise_1/hospitals
hdfs dfs -put /home/w205/exercise_1/staging/hospitals_stripped.csv /user/w205/exercise_1/hospitals
hdfs dfs -mkdir /user/w205/exercise_1/effective_care
hdfs dfs -put /home/w205/exercise_1/staging/effective_care_stripped.csv /user/w205/exercise_1/effective_care
hdfs dfs -mkdir /user/w205/exercise_1/measures
hdfs dfs -put /home/w205/exercise_1/staging/measures_stripped.csv /user/w205/exercise_1/measures
hdfs dfs -mkdir /user/w205/exercise_1/readmissions
hdfs dfs -put /home/w205/exercise_1/staging/readmissions_stripped.csv /user/w205/exercise_1/readmissions
hdfs dfs -mkdir /user/w205/exercise_1/surveys_responses
hdfs dfs -put /home/w205/exercise_1/staging/surveys_responses_stripped.csv /user/w205/exercise_1/surveys_responses
hdfs dfs -mkdir /user/w205/exercise_1/procedure_types
hdfs dfs -put /home/w205/exercise_1/staging/procedure_types.csv /user/w205/exercise_1/procedure_types
