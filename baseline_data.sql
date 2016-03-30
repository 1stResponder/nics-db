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

--
-- PostgreSQL database dump
-- Created with pg_dump -t formtype -t incidenttype -t messagepermissions -t orgtype  -t systemrole -t contacttype -t datasourcetype -t logtype -a --inserts dev.sacore > /tmp/baseline_data.sql
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: contacttype; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO contacttype VALUES (0, 'email');
INSERT INTO contacttype VALUES (1, 'phone_home');
INSERT INTO contacttype VALUES (2, 'phone_cell');
INSERT INTO contacttype VALUES (3, 'phone_office');
INSERT INTO contacttype VALUES (4, 'radio_number');
INSERT INTO contacttype VALUES (5, 'phone_other');


--
-- Data for Name: datasourcetype; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO datasourcetype VALUES ('wms', 1);
INSERT INTO datasourcetype VALUES ('kml', 2);
INSERT INTO datasourcetype VALUES ('wmts', 3);
INSERT INTO datasourcetype VALUES ('kmz', 4);
INSERT INTO datasourcetype VALUES ('wfs', 5);
INSERT INTO datasourcetype VALUES ('georss', 6);
INSERT INTO datasourcetype VALUES ('arcgisrest', 7);
INSERT INTO datasourcetype VALUES ('xyz', 8);
INSERT INTO datasourcetype VALUES ('osm', 9);
INSERT INTO datasourcetype VALUES ('google', 10);
INSERT INTO datasourcetype VALUES ('document', 11);
INSERT INTO datasourcetype VALUES ('arcgiscache', 12);
INSERT INTO datasourcetype VALUES ('gpx', 13);
INSERT INTO datasourcetype VALUES ('bing', 14);
INSERT INTO datasourcetype VALUES ('geojson', 15);


--
-- Data for Name: formtype; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO formtype VALUES (nextVal('form_seq'), 'ROC');
INSERT INTO formtype VALUES (nextVal('form_seq'), 'RESC');
INSERT INTO formtype VALUES (nextVal('form_seq'), 'ABC');
INSERT INTO formtype VALUES (nextVal('form_seq'), '215');
INSERT INTO formtype VALUES (nextVal('form_seq'), 'SITREP');
INSERT INTO formtype VALUES (nextVal('form_seq'), 'ASSGN');
INSERT INTO formtype VALUES (nextVal('form_seq'), 'SR');
INSERT INTO formtype VALUES (nextVal('form_seq'), 'FR');
INSERT INTO formtype VALUES (nextVal('form_seq'), 'TASK');
INSERT INTO formtype VALUES (nextVal('form_seq'), 'RESREQ');
INSERT INTO formtype VALUES (nextVal('form_seq'), '9110');
INSERT INTO formtype VALUES (nextVal('form_seq'), 'DMGRPT');
INSERT INTO formtype VALUES (nextVal('form_seq'), 'UXO');
INSERT INTO formtype VALUES (nextVal('form_seq'), 'SVRRPT');
INSERT INTO formtype VALUES (nextVal('form_seq'), 'AGRRPT');
INSERT INTO formtype VALUES (nextVal('form_seq'), 'MITAM');
--
-- Data for Name: incidenttype; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO incidenttype VALUES (1, 'Fire (Wildland)');
INSERT INTO incidenttype VALUES (2, 'Mass Casualty');
INSERT INTO incidenttype VALUES (3, 'Search and Rescue');
INSERT INTO incidenttype VALUES (4, 'Terrorist Threat / Attack');
INSERT INTO incidenttype VALUES (5, 'Fire (Structure)');
INSERT INTO incidenttype VALUES (6, 'Hazardous Materials');
INSERT INTO incidenttype VALUES (7, 'Blizzard');
INSERT INTO incidenttype VALUES (8, 'Hurricane');
INSERT INTO incidenttype VALUES (9, 'Earthquake');
INSERT INTO incidenttype VALUES (10, 'Nuclear Accident');
INSERT INTO incidenttype VALUES (11, 'Oil Spill');
INSERT INTO incidenttype VALUES (12, 'Planned Event');
INSERT INTO incidenttype VALUES (13, 'Public Health / Medical Emergency');
INSERT INTO incidenttype VALUES (14, 'Tornado');
INSERT INTO incidenttype VALUES (15, 'Tropical Storm');
INSERT INTO incidenttype VALUES (16, 'Tsunami');
INSERT INTO incidenttype VALUES (17, 'Aircraft Accident');
INSERT INTO incidenttype VALUES (18, 'Civil Unrest');
INSERT INTO incidenttype VALUES (19, 'Flood');


--
-- Data for Name: logtype; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO logtype VALUES (0, 'announcement');
INSERT INTO logtype VALUES (1, 'alert');


--
-- Data for Name: systemrole; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO systemrole VALUES (0, 'super');
INSERT INTO systemrole VALUES (1, 'user');
INSERT INTO systemrole VALUES (2, 'readOnly');
INSERT INTO systemrole VALUES (3, 'gis');
INSERT INTO systemrole VALUES (4, 'admin');


--
-- Data for Name: messagepermissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO messagepermissions VALUES (0, 'announcement'),(1, 'announcement'),(2, 'announcement'),(3, 'announcement'),(4, 'announcement');
INSERT INTO messagepermissions VALUES (0, 'createIncident'),(1, 'createIncident'),(3, 'createIncident'),(4, 'createIncident');
INSERT INTO messagepermissions VALUES (0, 'createofficialdl'),(4, 'createofficialdl');
INSERT INTO messagepermissions VALUES (0, 'createroom'),(1, 'createroom'),(3, 'createroom'),(4, 'createroom');
INSERT INTO messagepermissions VALUES (0, 'datalayer'),(1, 'datalayer'),(3, 'datalayer'),(4, 'datalayer');
INSERT INTO messagepermissions VALUES (0, 'document'),(3, 'document'),(4, 'document');
INSERT INTO messagepermissions VALUES (0, 'dr'),(1, 'dr'),(2, 'dr'),(3, 'dr'),(4, 'dr');
INSERT INTO messagepermissions VALUES (0, 'feat'),(1, 'feat'),(3, 'feat'),(4, 'feat');
INSERT INTO messagepermissions VALUES (0, 'folder'),(4, 'folder');
INSERT INTO messagepermissions VALUES (0, 'folderupdate'),(4, 'folderupdate');
INSERT INTO messagepermissions VALUES (0, 'incidentUpdate');
INSERT INTO messagepermissions VALUES (0, 'invite'),(1, 'invite'),(2, 'invite'),(3, 'invite'),(4, 'invite');
INSERT INTO messagepermissions VALUES (0, 'map'),(1, 'map'),(3, 'map'),(4, 'map');
INSERT INTO messagepermissions VALUES (0, 'msg'),(1, 'msg'),(2, 'msg'),(3, 'msg'),(4, 'msg');
INSERT INTO messagepermissions VALUES (0, 'myaccount'),(1, 'myaccount'),(2, 'myaccount'),(3, 'myaccount'),(4, 'myaccount');
INSERT INTO messagepermissions VALUES (0, 'newfolder'),(4, 'newfolder');
INSERT INTO messagepermissions VALUES (0, 'newIncidentFolder'),(1, 'newIncidentFolder'),(2, 'newIncidentFolder'),(3, 'newIncidentFolder'),(4, 'newIncidentFolder');
INSERT INTO messagepermissions VALUES (0, 'neworganization');
INSERT INTO messagepermissions VALUES (0, 'newuser'),(1, 'newuser'),(2, 'newuser'),(3, 'newuser'),(4, 'newuser');
INSERT INTO messagepermissions VALUES (0, 'private-msg'),(1, 'private-msg'),(2, 'private-msg'),(3, 'private-msg'),(4, 'private-msg');
INSERT INTO messagepermissions VALUES (0, 'removealert'),(4, 'removealert');
INSERT INTO messagepermissions VALUES (0, 'removefolder');
INSERT INTO messagepermissions VALUES (0, 'renamefolder'),(4, 'renamefolder');
INSERT INTO messagepermissions VALUES (0, 'res'),(1, 'res'),(2, 'res'),(3, 'res'),(4, 'res');
INSERT INTO messagepermissions VALUES (0, 'sitrep'),(1, 'sitrep'),(3, 'sitrep'),(4, 'sitrep');
INSERT INTO messagepermissions VALUES (0, 'sr'),(1, 'sr'),(2, 'sr'),(3, 'sr'),(4, 'sr');
INSERT INTO messagepermissions VALUES (0, 'stat'),(1, 'stat'),(2, 'stat'),(3, 'stat'),(4, 'stat');
INSERT INTO messagepermissions VALUES (0, 'sys'),(1, 'sys'),(2, 'sys'),(3, 'sys'),(4, 'sys');
INSERT INTO messagepermissions VALUES (0, 'tableCopierResponse'),(4, 'tableCopierResponse');
INSERT INTO messagepermissions VALUES (0, 'updateorganization'),(4, 'updateorganization');
INSERT INTO messagepermissions VALUES (0, 'updateuser'),(4, 'updateuser');

--
-- Data for Name: orgtype; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO orgtype VALUES (0, 'Fire/Rescue');
INSERT INTO orgtype VALUES (1, 'Law Enforcement');
INSERT INTO orgtype VALUES (2, 'Academia');
INSERT INTO orgtype VALUES (3, 'Office of Emergency Services');
INSERT INTO orgtype VALUES (4, 'Military');
INSERT INTO orgtype VALUES (5, 'Other Government');
INSERT INTO orgtype VALUES (6, 'Non-Governmental Organization');
INSERT INTO orgtype VALUES (7, 'Private Volunteer Organization');
INSERT INTO orgtype VALUES (8, 'Corporate');
INSERT INTO orgtype VALUES (9, 'IMT');
INSERT INTO orgtype VALUES (10, 'USAR');
INSERT INTO orgtype VALUES (11, 'Federal');
INSERT INTO orgtype VALUES (12, 'Other Local IMT');
INSERT INTO orgtype VALUES (13, 'CDF IMT');
INSERT INTO orgtype VALUES (14, 'Federal IMT');

INSERT INTO ics_position VALUES (100, 'IC_IC', 'Command', 'Incident Commander');
INSERT INTO ics_position VALUES (110, 'IC_PIO', 'Info', 'Public Information Officer');
INSERT INTO ics_position VALUES (120, 'IC_LO', 'Info', 'Liaison Officer');
INSERT INTO ics_position VALUES (130, 'IC_SO', 'Safety', 'Safety Oficer');
INSERT INTO ics_position VALUES (200, 'IO_OSC', 'Ops', 'Operations Section Chief');
INSERT INTO ics_position VALUES (210, 'IO_SAM', 'Ops', 'Staging Area Manager');
INSERT INTO ics_position VALUES (220, 'IO_AOD', 'Ops', 'Air Operations Director');
INSERT INTO ics_position VALUES (230, 'IO_BD', 'Ops', 'Branch Director');
INSERT INTO ics_position VALUES (240, 'IO_DS', 'Ops', 'Division Supervisor');
INSERT INTO ics_position VALUES (250, 'IO_GS', 'Ops', 'Group Supervisor');
INSERT INTO ics_position VALUES (260, 'IO_TFM', 'Ops', 'Task Force Member');
INSERT INTO ics_position VALUES (270, 'IO_STM', 'Ops', 'Strike Team Member');
INSERT INTO ics_position VALUES (280, 'IO_FO', 'Ops', 'Field Observer');

INSERT INTO ics_position VALUES (300, 'IP_RUL', 'Planning', 'Resources Unit Leader');
INSERT INTO ics_position VALUES (310, 'IP_SUL', 'Planning', 'Situation Unit Leader');
INSERT INTO ics_position VALUES (320, 'IP_DOCUL', 'Planning', 'Documentation Unit Leader');
INSERT INTO ics_position VALUES (330, 'IP_DMOBUL', 'Planning', 'Demobilization Unit Leader');
INSERT INTO ics_position VALUES (340, 'IP_EUL', 'Planning', 'Environmental Unit Leader');
INSERT INTO ics_position VALUES (350, 'IP_MTSRUL', 'Planning', 'Maritime Transportation System Recovery Unit Leader');

INSERT INTO ics_position VALUES (400, 'IL_SVCBD', 'Logistics', 'Service Branch Director');
INSERT INTO ics_position VALUES (410, 'IL_CUL', 'Logistics', 'Communications Unit Leader');
INSERT INTO ics_position VALUES (420, 'IL_MUL', 'Logistics', 'Medical Unit Leader');
INSERT INTO ics_position VALUES (430, 'IL_FOODUL', 'Logistics', 'Food Unit Leader');
INSERT INTO ics_position VALUES (440, 'IL_SUPBD', 'Logistics', 'Support Branch Direction');
INSERT INTO ics_position VALUES (450, 'IL_SUL', 'Logistics', 'Supply Unit Leader');
INSERT INTO ics_position VALUES (460, 'IL_FACLUL', 'Logistics', 'Facilities Unit Leader');
INSERT INTO ics_position VALUES (470, 'IL_GSUL', 'Logistics', 'Ground Support Unit Leader');
INSERT INTO ics_position VALUES (480, 'IL_VSIL', 'Logistics', 'Vessel Support Unit Leader');

