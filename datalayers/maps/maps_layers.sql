--
-- Copyright (c) 2008-2016, Massachusetts Institute of Technology (MIT)
-- All rights reserved.
--
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- 1. Redistributions of source code must retain the above copyright notice, this
-- list of conditions and the following disclaimer.
--
-- 2. Redistributions in binary form must reproduce the above copyright notice,
-- this list of conditions and the following disclaimer in the documentation
-- and/or other materials provided with the distribution.
--
-- 3. Neither the name of the copyright holder nor the names of its contributors
-- may be used to endorse or promote products derived from this software without
-- specific prior written permission.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-- IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
-- DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
-- FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
-- DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
-- SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
-- CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
-- OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-- OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--

-- PREREQUISITES: create_default_folders.sh

INSERT INTO datasource (datasourceid, datasourcetypeid, externalurl, internalurl, displayname) VALUES
    ('2DC0B332-C729-4E2F-AA00-1263C19361E4', 14, '', '', ''),
    ('B89C4D59-0F5F-499C-B2DA-99BE1DE70358', 9, '', '', ''),
    ('7F917569-1F43-4E1A-8C65-97F6161896AD', 8, '', 'http://services.arcgisonline.com/ArcGIS/rest/services/USA_Topo_Maps/MapServer/tile/{z}/{y}/{x}', ''),
    ('698CC638-57E7-4390-868D-AA3E886E052B', 8, '', 'http://download.iflightplanner.com/Maps/Tiles/Sectional/Z{z}/{y}/{x}.jpg', '');

INSERT INTO datalayersource (datalayersourceid, datasourceid, usersessionid, attributes, created, refreshrate) VALUES
    ('9CEBB7DE-666E-4907-AB32-F4FBF824B01B', '2DC0B332-C729-4E2F-AA00-1263C19361E4', 1, '{"type":"Road"}', now(), 0),
    ('C4809132-61BE-4381-A53B-0DA96F292754', '2DC0B332-C729-4E2F-AA00-1263C19361E4', 1, '{"type":"Aerial"}', now(), 0),
    ('09C0D4BC-00CD-4BD0-8058-6D675DDE38F3', '2DC0B332-C729-4E2F-AA00-1263C19361E4', 1, '{"type":"AerialWithLabels"}', now(), 0),
    ('58A31356-1374-4E27-9257-72598C3CAF9F', 'B89C4D59-0F5F-499C-B2DA-99BE1DE70358', 1, '{}', now(), 0),
    ('A5322DF7-4B68-48F4-B1ED-17DE0ECF5B1A', '7F917569-1F43-4E1A-8C65-97F6161896AD', 1, '{"maxZoom": 15}', now(), 0),
    ('0127A876-5DA6-438B-B0D8-10B5F682B388', '698CC638-57E7-4390-868D-AA3E886E052B', 1, '{"maxZoom": 11}', now(), 0);

INSERT INTO datalayer (datalayerid, datalayersourceid, usersessionid, baselayer, created, displayname, globalview) VALUES
    ('D99E1117-02F8-44ED-97D2-3433E7466164', '9CEBB7DE-666E-4907-AB32-F4FBF824B01B', 1, true, now(), 'Bing Roads', true),
    ('71F2940E-7F67-4DAB-A47B-25717E66C33F', 'C4809132-61BE-4381-A53B-0DA96F292754', 1, true, now(), 'Bing Aerial', true),
    ('8E21F800-9FDE-42A2-8434-8FDF0B2ECD17', '09C0D4BC-00CD-4BD0-8058-6D675DDE38F3', 1, true, now(), 'Bing Aerial With Labels', true),
    ('70597147-934C-43C2-88ED-745631B06A4B', '58A31356-1374-4E27-9257-72598C3CAF9F', 1, true, now(), 'Open Street Map', true),
    ('1A091F5B-9DA6-4107-AE64-7DF0F27CB14B', 'A5322DF7-4B68-48F4-B1ED-17DE0ECF5B1A', 1, true, now(), 'US Topo - 7.5 min. quadrangle maps', true),
    ('2054EF21-DF74-4734-8E9B-893D77D246DA', '0127A876-5DA6-438B-B0D8-10B5F682B388', 1, true, now(), 'FAA - Sectional Aeronautical Charts', true);

INSERT INTO datalayerfolder (datalayerfolderid, datalayerid, folderid, index) VALUES
    ((select nextval('hibernate_sequence')), 'D99E1117-02F8-44ED-97D2-3433E7466164', (select folderid from folder where foldername='Maps' and workspaceid=1), 2),
    ((select nextval('hibernate_sequence')), '71F2940E-7F67-4DAB-A47B-25717E66C33F', (select folderid from folder where foldername='Maps' and workspaceid=1), 3),
    ((select nextval('hibernate_sequence')), '8E21F800-9FDE-42A2-8434-8FDF0B2ECD17', (select folderid from folder where foldername='Maps' and workspaceid=1), 1),
    ((select nextval('hibernate_sequence')), '70597147-934C-43C2-88ED-745631B06A4B', (select folderid from folder where foldername='Maps' and workspaceid=1), 0),
    ((select nextval('hibernate_sequence')), '1A091F5B-9DA6-4107-AE64-7DF0F27CB14B', (select folderid from folder where foldername='Maps' and workspaceid=1), 4),
    ((select nextval('hibernate_sequence')), '2054EF21-DF74-4734-8E9B-893D77D246DA', (select folderid from folder where foldername='Maps' and workspaceid=1), 5);
    
