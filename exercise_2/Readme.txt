ASSUMPTIONS:
------------
Instance is created using UCB W205 Spring 2016 (ami-be0d5fd4)
setup_ucb_complete_plus_postgres.sh had been run successfully per Lab2 instruction
Python 2.7.3 
PostgreSQL 8.4.20
StreamParse, psycopg2 and tweepy had been installed as described in step-1 and step-2 sections in Exercise-2 instruction


STEPS TO RUN EX2:
-----------------

1.	log into EC2 instance

2.	copy all the directories and files of "exercise_2" pulled from Github submission. 

3.	“exercise_2” is now the root directory

     cd exercise_2

4.	under exercise_2, run the database set up script. This should mount /data directory and start postgres.

     chmod a+x db_setup.sh
     bash db_setup.sh

5.	Change directory into tweetwordcount application

     cd tweetwordcount

6.	Run tweetwordcount application

     sparse run

7.	Press Enter/Return to continue as root. Let the application run for a couple of minutes and press control-c to interrupt the streaming.

8.	Go back to exercise_2 directory

     cd ..

9.	Run finalresults.py without argument

     python serving/finalresults.py

10.	Run finalresults.py with argument

     python serving/finalresults.py the

11.	Run histogram.py with arguments

     python serving/histogram.py 9,10
