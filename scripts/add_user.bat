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
  echo ERROR: First argument must specify a username name to create and populate.
  call :PRINTUSAGE
  exit /B 1
)

if "%~2" == "" (
  echo ERROR: Second argument must specify an organization's id. NOTE: Query the org table.
  call :PRINTUSAGE
  exit /B 1
)

if "%~3" == "" (
  echo ERROR: Third argument must specify a workspace id. NOTE: Query the workspace table.
  call :PRINTUSAGE
  exit /B 1
)

if "%~4" == "" (
  echo ERROR: Fourth argument must specify a first name 
  call :PRINTUSAGE
  exit /B 1
)

if "%~5" == "" (
  echo ERROR: Fith argument must specify a last name
  call :PRINTUSAGE
  exit /B 1
)

if "%~6" == "" (
  echo ERROR: Sixth argument must specify a password
  call :PRINTUSAGE
  exit /B 1
)

if "%~7" == "" (
  echo ERROR: Sixth argument must specify a role
  call :PRINTUSAGE
  exit /B 1
)

REM create the database
psql -U postgres -w -c "INSERT INTO \"user\" VALUES ((select nextval('user_seq')), '%~1', '%6', '%4', '%5', now(), true, now(), '\x1cf09e162a9b3bbe20e7c0aaffec9e4d','t',now())" nics
psql -U postgres -w -c "INSERT INTO userorg VALUES ((select nextval('user_org_seq')), (select last_value from user_seq), '%~2', '%~7', now(), NULL, '', '', '')" nics
psql -U postgres -w -c "INSERT INTO userorg_workspace VALUES (%~3, (select last_value from user_org_seq), (select nextval('hibernate_sequence')), 't')" nics
psql -U postgres -w -c "INSERT INTO usersession values((select nextval('user_session_seq')), (select last_value from user_org_seq), 'default-session-id', now(), now())" nics
exit /B 0

:PRINTUSAGE
echo USAGE: add_user.bat Username OrgId WorkspaceId
GOTO :eof

endlocal
@echo on


