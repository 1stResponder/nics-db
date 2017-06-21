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

REM create the database
psql -U postgres -w -c "create database %1"

REM create the database
psql -U postgres -w -c "create user nics"

REM now create baseline schema and insert baseline data
psql -U postgres -w -f baseline.sql "%1"
psql -U postgres -w -f baseline_data.sql "%1"

REM now execute incremental change scripts with:
REM psql -w -f <script_name> "$1"

REM psql -U postgres -w -f ./changes/April_Sprint_Changes.sql "%1"
REM psql -U postgres -w -f ./changes/May_Sprint_Changes.sql "%1"
REM psql -U postgres -w -f ./changes/June_Sprint_Changes_1.sql "%1"

endlocal
@echo on