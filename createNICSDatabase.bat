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

REM now create baseline schema and insert baseline data
call create_db.bat %1

if %ERRORLEVEL% == 0 (
	echo NICS Database and Role Added > CON
	echo. > CON
)

call create_data_dbs.bat %1

if %ERRORLEVEL% == 0 (
	echo Supporting NICS Databases Added > CON
	echo. > CON
)

endlocal
@echo on