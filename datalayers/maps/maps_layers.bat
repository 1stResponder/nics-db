@echo off
setlocal
REM
REM (c) Copyright, 2015 Ardent Management Consulting, All Rights Reserved
REM
REM     This material may be reproduced by or for the
REM     U.S. Government pursuant to the copyright license
REM     under the clause at DFARS 252.227-7013 (June, 1995).
REM

if "%~1" == "" (
  echo ERROR: You must specify a database name to add the map layers.
  exit /B 1
)
REM prompt for the postgres user's password and store it in the PGPASSWORD variable to prevent additional prompts.
set /P PGPASSWORD=Enter postgres password: 

REM now create the map layers
psql -U postgres -f maps_layers.sql %1


endlocal
@echo on