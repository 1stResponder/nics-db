@echo off
setlocal
REM
REM (c) Copyright, 2015 Ardent Management Consulting, All Rights Reserved
REM
REM     This material may be reproduced by or for the
REM     U.S. Government pursuant to the copyright license
REM     under the clause at DFARS 252.227-7013 (June, 1995).
REM

REM creating the layers
pushd weather
call weather_layers.bat %1

if %ERRORLEVEL% == 0 (
	echo  Weather Layers Added Successfully. > CON
	echo. > CON
)
popd

pushd maps
call maps_layers.bat %1

if %ERRORLEVEL% == 0 (
	echo  Map Layers Added Successfully. > CON
	echo. > CON
)
popd

endlocal
@echo on