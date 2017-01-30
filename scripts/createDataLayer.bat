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

psql -U postgres -c  "INSERT INTO folder(folderid,foldername,workspaceid) VALUES ('f673e108-7ca0-4907-8b62-ebf3d56e91f6','Data',1)" nics
psql -U postgres -c  "INSERT INTO folder(folderid,foldername,workspaceid) VALUES ('C6659C73-3BF2-4F7F-90AD-7EEFE9D4EEBA','Maps',1)" nics
psql -U postgres -c  "INSERT INTO folder(folderid,foldername,workspaceid) VALUES ('371D4DE7-10BC-462B-81C2-4199C332BBEF','Weather',1)" nics
psql -U postgres -c  "INSERT INTO folder(folderid,foldername,workspaceid) VALUES ('3103D8FC-990F-4EF1-9D0E-F3490A05A0EB','Tracking',1)" nics
psql -U postgres -c  "INSERT INTO folder(folderid,foldername,parentfolderid,index,workspaceid) VALUES ('2088F0E0-3B8E-4715-92AA-59DE29C8516B','Upload','f673e108-7ca0-4907-8b62-ebf3d56e91f6',0,1)" nics

psql -U postgres -c  "INSERT INTO rootfolder(rootid,folderid,tabname,workspaceid) VALUES (1,'C6659C73-3BF2-4F7F-90AD-7EEFE9D4EEBA','Maps',1)" nics
psql -U postgres -c  "INSERT INTO rootfolder(rootid,folderid,tabname,workspaceid) VALUES (2,'f673e108-7ca0-4907-8b62-ebf3d56e91f6','Data',1)" nics
psql -U postgres -c  "INSERT INTO rootfolder(rootid,folderid,tabname,workspaceid) VALUES (3,'371D4DE7-10BC-462B-81C2-4199C332BBEF','Weather',1)" nics
psql -U postgres -c  "INSERT INTO rootfolder(rootid,folderid,tabname,workspaceid) VALUES (4,'3103D8FC-990F-4EF1-9D0E-F3490A05A0EB','Tracking',1)" nics

psql -U postgres -c  "INSERT INTO datalayersource(created, datalayersourceid,datasourceid,refreshrate,usersessionid) VALUES (now(),'0b79bd02-bf28-494d-aa2f-f2ce858d9db8','D09B9B86-008A-4032-A881-60CCF4A50916',0,1)" nics
psql -U postgres -c  "INSERT INTO datalayersource(created,datalayersourceid,datasourceid,refreshrate,usersessionid) VALUES (now(),'62352220-c0f9-4652-a412-28e6b2fdaa95','D09B9B86-008A-4032-A881-60CCF4A50916',0,1)" nics

psql -U postgres -c  "INSERT INTO datalayer(usersessionid,created,datalayerid,baselayer,datalayersourceid,displayname,globalview) VALUES (1,now(),'c09cc1e1-1d69-4b49-9f30-683d55213ed6','t','0b79bd02-bf28-494d-aa2f-f2ce858d9db8','Data Legend','t')" nics
psql -U postgres -c  "INSERT INTO datalayer(usersessionid,created,datalayerid,baselayer,datalayersourceid,displayname,globalview) VALUES (1,now(),'16d3c7e8-dfa4-42aa-a25e-4c9dd01a0a75','t','62352220-c0f9-4652-a412-28e6b2fdaa95','Weather Legend','t')" nics
c

psql -U postgres -c  "INSERT INTO datalayerfolder(datalayerfolderid,datalayerid,folderid,index) VALUES (10,'16d3c7e8-dfa4-42aa-a25e-4c9dd01a0a75','371D4DE7-10BC-462B-81C2-4199C332BBEF',0)" nics
psql -U postgres -c  "INSERT INTO datalayerfolder(datalayerfolderid,datalayerid,folderid,index) VALUES (11,'c09cc1e1-1d69-4b49-9f30-683d55213ed6','f673e108-7ca0-4907-8b62-ebf3d56e91f6',0)" nics

endlocal
@echo on