@echo off
setlocal
REM
REM (c) Copyright, 2015 Ardent Management Consulting, All Rights Reserved
REM
REM     This material may be reproduced by or for the
REM     U.S. Government pursuant to the copyright license
REM     under the clause at DFARS 252.227-7013 (June, 1995).
REM

REM drop the NICS databases
psql -U postgres -c "drop database if exists nics"
psql -U postgres -c "drop database if exists \"nics.datafeeds\""
psql -U postgres -c "drop database if exists \"nics.datalayers_postgis\""
psql -U postgres -c "drop database if exists \"nics.shapefiles\""

endlocal
@echo on