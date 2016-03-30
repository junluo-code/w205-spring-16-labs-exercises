#!/bin/bash

#mount data directory
mount -t ext4 /dev/xvdf /data

#start Postgres
/data/start_postgres.sh
sleep 5

#set up tcount.tweetwordcount
psql -U postgres -c "DROP DATABASE IF EXISTS tcount;"
psql -U postgres -c "CREATE DATABASE tcount;"
psql -U postgres -d tcount -c "DROP TABLE IF EXISTS tweetwordcount;"
psql -U postgres -d tcount -c "CREATE TABLE tweetwordcount (word TEXT PRIMARY KEY NOT NULL, count INT NOT NULL);"