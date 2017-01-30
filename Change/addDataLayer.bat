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

psql -U postgres -c  "insert into datasource VALUES('D09B9B86-008A-4032-A881-60CCF4A50916', '', 'http://nics-dev-am.pscloud.org/static/upload/kml', 2)" nics
psql -U postgres -c  "insert into datasource VALUES('0C44F5D7-BC68-4743-BA67-AB71A1557A1F','', 'http://nics-dev-am.pscloud.org/static/upload/gpx', 13)" nics
psql -U postgres -c  "insert into datasource VALUES('F167CFA4-0895-4AE6-8A03-F3BEE861C613','', 'http://nics-dev-am.pscloud.org/static/upload/arcgisrest', 7)" nics
psql -U postgres -c  "insert into datasource VALUES('B2BEEA0A-AA28-483B-9C32-6C333C30A87E','', 'http://nics-dev-am.pscloud.org/static/upload/geojson', 15)" nics
psql -U postgres -c  "insert into datasource VALUES('3957BC76-5684-43F0-BEF7-0246C9A0B8A2','', 'http://nics-dev-am.pscloud.org/static/upload/kmz', 4)" nics

psql -U postgres -c  "insert into datalayersource VALUES('AAA21937-B504-4F42-81B1-81B496F919AF', now(), 'D09B9B86-008A-4032-A881-60CCF4A50916', 'image/png', '/CA7A9021-4C77-4533-B6CF-464850B82784.kml', 'EPSG:4326', 0, null, null, null, 1)" nics

psql -U postgres -c  "insert into datalayer VALUES('2FF1840D-1B12-4CD1-B1BE-A8350890AAFF', false, now(), 'AAA21937-B504-4F42-81B1-81B496F919AF', 'CALFIRE Facilities (KML)', 't', 1)" nics

psql -U postgres -c  "INSERT INTO datalayersource(created, datalayersourceid,datasourceid,refreshrate,usersessionid, opacity) VALUES (now(),'0b79bd02-bf28-494d-aa2f-f2ce858d9db8','D09B9B86-008A-4032-A881-60CCF4A50916',0,1,1)" nics
psql -U postgres -c  "INSERT INTO datalayersource(created,datalayersourceid,datasourceid,refreshrate,usersessionid, opacity) VALUES (now(),'62352220-c0f9-4652-a412-28e6b2fdaa95','D09B9B86-008A-4032-A881-60CCF4A50916',0,1,1)" nics

psql -U postgres -c  "INSERT INTO datalayer(usersessionid,created,datalayerid,baselayer,datalayersourceid,displayname,globalview) VALUES (1,now(),'c09cc1e1-1d69-4b49-9f30-683d55213ed6','t','0b79bd02-bf28-494d-aa2f-f2ce858d9db8','Data Legend','t')" nics
psql -U postgres -c  "INSERT INTO datalayer(usersessionid,created,datalayerid,baselayer,datalayersourceid,displayname,globalview) VALUES (1,now(),'16d3c7e8-dfa4-42aa-a25e-4c9dd01a0a75','t','62352220-c0f9-4652-a412-28e6b2fdaa95','Weather Legend','t')" nics

psql -U postgres -c  "INSERT INTO datalayerfolder(datalayerfolderid,datalayerid,folderid,index) VALUES (10,'16d3c7e8-dfa4-42aa-a25e-4c9dd01a0a75','371D4DE7-10BC-462B-81C2-4199C332BBEF',0)" nics
psql -U postgres -c  "INSERT INTO datalayerfolder(datalayerfolderid,datalayerid,folderid,index) VALUES (11,'c09cc1e1-1d69-4b49-9f30-683d55213ed6','f673e108-7ca0-4907-8b62-ebf3d56e91f6',0)" nics

endlocal
@echo on