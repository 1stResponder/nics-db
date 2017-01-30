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
  echo ERROR: You must specify a database name to create and populate.
  echo(
  call :PRINTUSAGE
  exit /B 1
)

REM prompt for the postgres user's password and store it in the PGPASSWORD variable to prevent additional prompts.
set /P PGPASSWORD=Enter postgres password: 

REM create the postgis enabled databases
createdb -U postgres  "%1.datalayers_postgis"
psql -U postgres -c "CREATE EXTENSION postgis" "%1.datalayers_postgis"

createdb -U postgres "%1.shapefiles"
psql -U postgres -c "CREATE EXTENSION postgis" "%1.shapefiles"

createdb -U postgres "%1.datafeeds"
psql -U postgres -c "CREATE EXTENSION postgis" "%1.datafeeds"

REM create baseline schema for datalayers_postgis database
psql -U postgres -f datalayers_baseline.sql "%1.datalayers_postgis"
exit /B 0

:PRINTUSAGE
echo USAGE: create_data_dbs.bat DatabaseName
GOTO :eof

endlocal
@echo on
