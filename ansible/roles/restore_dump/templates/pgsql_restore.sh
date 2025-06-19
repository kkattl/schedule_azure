#!/bin/bash

#change on your path to PostgreSQL
#pathA=/c/Program\ Files/PostgreSQL/13/bin
#export PATH=$PATH:$pathA

#write your password
PGPASSWORD="Password123!"
export PGPASSWORD

#change the path to the file from which will be made restore
#write this on the command line as the first parameter
filename=$1
#write your user
dbUser="postgre"
#write your database
database="postgres"
#write your host
host=localhost
#write your port
port=50023

psql -U $dbUser -h $host -p $port -d $database -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"
psql --set ON_ERROR_STOP=off -U $dbUser -h $host -p $port -d $database -1 -f $filename

unset PGPASSWORD