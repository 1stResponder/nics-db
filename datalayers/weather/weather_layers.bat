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
  echo ERROR: You must specify a database name to copy the weather layers.
  exit /B 1
)
REM prompt for the postgres user's password and store it in the PGPASSWORD variable to prevent additional prompts.
set /P PGPASSWORD=Enter postgres password: 

REM now create weather layers
psql -U postgres -c "\COPY folder FROM '%cd%\folders.sql'" %1
psql -U postgres -c "\COPY rootfolder FROM '%cd%\root_folders.sql'" %1
psql -U postgres -c "\COPY folder FROM '%cd%\weather_folders.sql'" %1
psql -U postgres -c "\COPY datasource FROM '%cd%\weather_datasource.sql'" %1
psql -U postgres -c "\COPY datalayersource FROM '%cd%\weather_datalayersource.sql'" %1
psql -U postgres -c "\COPY datalayer FROM '%cd%\weather_datalayer.sql'" %1
psql -U postgres -c "\COPY datalayerfolder FROM '%cd%\weather_datalayerfolder.sql'" %1

endlocal
@echo on