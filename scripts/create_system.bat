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
  echo ERROR: First argument must specify a system name.
  echo(  
  echo  Name of the system - this usually corresponds to the application's hostname.
  echo  For example, if the site is hosted at "nics.ll.mit.edu", this system name would be "nics".
  echo(
  call :PRINTUSAGE
  exit /B 1
)

if "%~2" == "" (
  echo ERROR: Second argument must specify a system description.
  echo(  
  echo  A description of the system.
  echo( 
  call :PRINTUSAGE
  exit /B 1
)

if "%~3%" == "" (
  echo ERROR: Third argument must specify a system id.
  echo(  
  echo  A unique system id - recommend starting with 1
  echo(    
  call :PRINTUSAGE
  exit /B 1
)

if "%~4" == "" (
  echo ERROR: Fourth argument must specify a workspace name.
  echo(  
  echo  A workspace name - this will appear as a button on the main page, for example "Incident"
  echo(    
  call :PRINTUSAGE
  exit /B 1
)

if "%~5" == "" (
  echo ERROR: Fifth argument must specify a workspace id.
  echo(  
  echo  A unique workspace id - recommend starting with 1
  echo(    
  call :PRINTUSAGE
  exit /B 1
)


REM prompt for the postgres user's password and store it in the PGPASSWORD variable to prevent additional prompts.
set /P PGPASSWORD=Enter postgres password: 

 
REM a system with a new workspace
psql -U postgres -c "INSERT INTO nicssystem VALUES (%~3, '%~1', '%~2', true)" nics
psql -U postgres -c "INSERT INTO workspace VALUES (%~5, '%~4', true)" nics
psql -U postgres -c "INSERT INTO system_workspace VALUES ((select nextval('hibernate_sequence')), %~3, %~5)" nics
exit /B 0

:PRINTUSAGE
echo USAGE: create_system.bat SystemName SystemDescription SystemId WorkspaceName WorkspaceId
GOTO :eof

endlocal
@echo on


