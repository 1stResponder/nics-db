@echo off
setlocal
REM
REM (c) Copyright, 2015 Ardent Management Consulting, All Rights Reserved
REM
REM     This material may be reproduced by or for the
REM     U.S. Government pursuant to the copyright license
REM     under the clause at DFARS 252.227-7013 (June, 1995).
REM

if "%1" == "" (
  echo ERROR: First argument must specify a database name to create and populate.
  exit /B 1
)

REM prompt for the postgres user's password and store it in the PGPASSWORD variable to prevent additional prompts.
set /P PGPASSWORD=Enter postgres password: 

REM create the database
psql -U postgres -c "create database %1"

REM create the database
psql -U postgres -c "create user nics"

REM now create baseline schema and insert baseline data
psql -U postgres -f baseline.sql "%1"
psql -U postgres -f baseline_data.sql "%1"

REM now execute incremental change scripts with:
REM psql -f <script_name> "$1"

REM psql -U postgres -f ./changes/April_Sprint_Changes.sql "%1"
REM psql -U postgres -f ./changes/May_Sprint_Changes.sql "%1"
REM psql -U postgres -f ./changes/June_Sprint_Changes_1.sql "%1"

endlocal
@echo on