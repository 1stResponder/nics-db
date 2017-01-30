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
  echo ERROR: First argument must specify a name for the organization.
  echo(
  call :PRINTUSAGE
  exit /B 1
)

if "%~2" == "" (
  echo ERROR: Second argument must specify a county for the organization.
  echo( 
  call :PRINTUSAGE
  exit /B 1
)

if "%~3%" == "" (
  echo ERROR: Third argument must specify a state for the organization.
  echo(    
  call :PRINTUSAGE
  exit /B 1
)

if "%~4" == "" (
  echo ERROR: Fourth argument must specify a prefix for the organization.
  echo(    
  call :PRINTUSAGE
  exit /B 1
)

if "%~5" == "" (
  echo ERROR: Fifth argument must specify an orgtype id - this will allow users to register with this organization. The ids can be found in the orgtype table.
  echo ======================================
  echo 0 = "Fire/Rescue"
  echo 1 = "Law Enforcement"
  echo 2 = "Academia"
  echo 3 = "Office of Emergency Services"
  echo 4 = "Military"
  echo 5 = "Other Government"
  echo 6 = "Non-Governmental Organization"
  echo 7 = "Private Volunteer Organization"
  echo 8 = "Corporate"
  echo 9 = "IMT"
  echo 10 = "USAR"
  echo 11 = "Federal"
  echo 12 = "Other Local IMT"
  echo 13 = "CDF IMT"
  echo 14 = "Federal IMT"
  echo ======================================  
  echo(    
  call :PRINTUSAGE
  exit /B 1
)

REM prompt for the postgres user's password and store it in the PGPASSWORD variable to prevent additional prompts.
set /P PGPASSWORD=Enter postgres password: 

REM create the org
psql -U postgres -c "INSERT INTO org VALUES ((select nextval('org_seq')), '%~1', '%~2', '%~3', NULL, '%~4', NULL, 38.8950000000000031, -77.0366700000000009, NULL, 'USA', now())" nics
psql -U postgres -c "INSERT INTO org_orgtype VALUES ((select nextval('hibernate_sequence')), (select last_value from org_seq), %~5)" nics
exit /B 0


:PRINTUSAGE
echo USAGE: create_org.bat OrgName OrgCounty OrgState OrgPrefix OrgTypeId
GOTO :eof

endlocal
@echo on
