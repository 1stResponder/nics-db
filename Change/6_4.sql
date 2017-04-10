SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

/*------------------------------------------------------------------*/
/*----- Adding Missing Tables with their sequences (if needed) -----*/
/*------------------------------------------------------------------*/



/** Alter **/
AlTER TABLE image add column fullpath character varying(250) NOT NULL;
ALTER TABLE orgfolder ADD PRIMARY KEY(orgfolderid);
ALTER TABLE system_workspace ADD PRIMARY KEY(system_workspace_id);

ALTER TABLE feature
ADD graphicurl character varying(256);

ALTER TABLE feature
ADD the_geom geometry;

/*-- orgcap + seq --*/

CREATE TABLE orgcap (
    orgcapid integer NOT NULL,
    orgId integer NOT NULL,
    capid integer NOT NULL,
    activeweb boolean DEFAULT true NOT NULL,
    activemobile boolean DEFAULT false NOT NULL,
    lastupdate timestamp without time zone DEFAULT now() NOT NULL,
    PRIMARY KEY(orgcapid)
);

ALTER TABLE orgcap OWNER TO nics;

CREATE SEQUENCE orgcapid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE orgcapid_seq OWNER TO nics;

ALTER SEQUENCE orgcapid_seq OWNED BY orgcap.orgcapid;

ALTER TABLE ONLY orgcap ALTER COLUMN orgcapid SET DEFAULT nextval('orgcapid_seq'::regclass);

/*-- cap + seq --*/
CREATE TABLE cap (
    capid integer NOT NULL,
    name character varying(15),
    description character varying(60),
    PRIMARY KEY(capid)
);

ALTER TABLE cap OWNER TO nics;

CREATE SEQUENCE capid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE capid_seq OWNER TO nics;

ALTER SEQUENCE capid_seq OWNED BY cap.capid;

ALTER TABLE ONLY cap ALTER COLUMN capid SET DEFAULT nextval('capid_seq'::regclass);

/*-- datalayer_org --*/
CREATE TABLE datalayer_org (
    datalayer_orgid character varying(255) NOT NULL,
    datalayerid character varying(255) NOT NULL,
    orgId integer NOT NULL,
    PRIMARY KEY(datalayer_orgid)
);

ALTER TABLE datalayer_org OWNER TO nics;

CREATE SEQUENCE datalayer_orgid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE datalayer_orgid_seq OWNER TO nics;

ALTER SEQUENCE datalayer_orgid_seq OWNED BY datalayer_org.datalayer_orgid;

ALTER TABLE ONLY datalayer_org ALTER COLUMN datalayer_orgid SET DEFAULT nextval('datalayer_orgid_seq'::regclass);

/*-- collabroomdatalayer --*/

CREATE TABLE collabroomdatalayer (
    collabroomdatalayerid integer NOT NULL,
    collabroomid integer NOT NULL,
    datalayerid character varying(255) NOT NULL,
    userId character varying(255) NOT NULL
);

ALTER TABLE collabroomdatalayer OWNER TO nics;

/*-- Image feature table --*/

CREATE TABLE imagefeature (
    imageid character varying(255) NOT NULL,
    location character varying(255),
    filename character varying(255)
);

ALTER TABLE imagefeature OWNER TO nics;

/*-- alert --*/

CREATE TABLE alert (
    alertid integer NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    message text,
    username character varying(100),
    PRIMARY KEY(alertid)
);

ALTER TABLE alert OWNER TO nics;

CREATE SEQUENCE alert_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE alert_seq OWNER TO nics;
ALTER SEQUENCE alert_seq OWNED BY alert.alertid;


/*-- alertuser --*/

CREATE TABLE alertuser (
    alertuserid integer NOT NULL,
    userId integer,
    alertid integer NOT NULL,
    incidentId integer NOT NULL,
    PRIMARY KEY(alertuserid)
);

ALTER TABLE alertuser OWNER TO nics;

CREATE SEQUENCE alert_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE alert_user_seq OWNER TO nics;
ALTER SEQUENCE alert_user_seq OWNED BY alertuser.alertuserid;

/*------------------------------------------------------------------*/
/*--------------------- Adding Missing sequences -------------------*/
/*------------------------------------------------------------------*/

CREATE SEQUENCE formid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 9
  CACHE 1;

ALTER TABLE formid_seq OWNER TO nics;
ALTER SEQUENCE formid_seq OWNED BY form.formid;

ALTER TABLE ONLY form ALTER COLUMN formid SET DEFAULT nextval('formid_seq'::regclass);
/*-----------   Adding system_workspac_id sequence*/

CREATE SEQUENCE system_workspace_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 2
  CACHE 1;

ALTER TABLE system_workspace_id_seq OWNER TO nics;
ALTER SEQUENCE system_workspace_id_seq OWNED BY system_workspace.system_workspace_id;

ALTER TABLE ONLY system_workspace ALTER COLUMN system_workspace_id SET DEFAULT nextval('system_workspace_id_seq'::regclass);

/*-----------   Adding collabroomdatalayer_collabroomdatalayerid_seq sequence*/

CREATE SEQUENCE collabroomdatalayer_collabroomdatalayerid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 91
  CACHE 1;

ALTER TABLE collabroomdatalayer_collabroomdatalayerid_seq OWNER TO nics;
ALTER SEQUENCE collabroomdatalayer_collabroomdatalayerid_seq OWNED BY collabroomdatalayer.collabroomdatalayerid;

ALTER TABLE ONLY collabroomdatalayer ALTER COLUMN collabroomdatalayerid SET DEFAULT nextval('collabroomdatalayer_collabroomdatalayerid_seq'::regclass);

/*------------------------------------------------------------------*/
/*--------------------- Adding Missing Values ----------------------*/
/*------------------------------------------------------------------*/

INSERT INTO formtype VALUES (nextVal('form_seq'), 'GAR');
INSERT INTO formtype VALUES (nextVal('form_seq'), '201');
INSERT INTO formtype VALUES (nextVal('form_seq'), '202');
INSERT INTO formtype VALUES (nextVal('form_seq'), '203');
INSERT INTO formtype VALUES (nextVal('form_seq'), '204');
INSERT INTO formtype VALUES (nextVal('form_seq'), '205');
INSERT INTO formtype VALUES (nextVal('form_seq'), '206');

INSERT INTO cap VALUES (nextVal('capid_seq'), 'SR', 'Shows SR Reports');
INSERT INTO cap VALUES (nextVal('capid_seq'), 'DMGRPT', 'Show Damage Reports');


INSERT INTO folder VALUES (42f0d320-d381-11e6-bf26-cec0c932ce01, 'Damage', '29116d2a-d381-11e6-bf26-cec0c932ce01',2,1);

INSERT INTO folder VALUES (b3b2e0e4-d381-11e6-bf26-cec0c932ce01,'General',29116d2a-d381-11e6-bf26-cec0c932ce01,2,1);
INSERT INTO folder VALUES (3103D8FC-990F-4EF1-9D0E-F3490A05A0EB,'Reports',f673e108-7ca0-4907-8b62-ebf3d56e91f6,1,1);


INSERT INTO orgcap VALUES (nextVal('orgcapid_seq'),1,1,TRUE,FALSE);
INSERT INTO orgcap VALUES (nextVal('orgcapid_seq'),1,2,TRUE,FALSE);

INSERT INTO datasourcetype VALUES ('image', 16);

CREATE SEQUENCE orgfolderid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE orgfolderid_seq OWNER TO nics;

ALTER SEQUENCE orgfolderid_seq OWNED BY orgfolder.orgfolderid;

ALTER TABLE ONLY orgfolder ALTER COLUMN orgfolderid SET DEFAULT nextval('orgfolderid_seq'::regclass);


/* datasource */
INSERT INTO datasource VALUES('D09B9B86-008A-4032-A881-60CCF4A50916', '', 'http://nics-dev-am.pscloud.org/static/upload/kml', 2);

INSERT INTO datasource VALUES('0C44F5D7-BC68-4743-BA67-AB71A1557A1F','', 'http://nics-dev-am.pscloud.org/static/upload/gpx', 13);

INSERT INTO datasource VALUES('F167CFA4-0895-4AE6-8A03-F3BEE861C613','', 'http://nics-dev-am.pscloud.org/static/upload/arcgisrest', 7);

INSERT INTO datasource VALUES('B2BEEA0A-AA28-483B-9C32-6C333C30A87E','', 'http://nics-dev-am.pscloud.org/static/upload/geojson', 15);

INSERT INTO datasource VALUES('3957BC76-5684-43F0-BEF7-0246C9A0B8A2','', 'http://nics-dev-am.pscloud.org/static/upload/kmz', 4);

/* Datalayerfolder values  */

INSERT INTO datalayerfolder(datalayerfolderid,datalayerid,folderid,index) VALUES (10,'16d3c7e8-dfa4-42aa-a25e-4c9dd01a0a75','371D4DE7-10BC-462B-81C2-4199C332BBEF',0);

INSERT INTO datalayerfolder(datalayerfolderid,datalayerid,folderid,index) VALUES (11,'c09cc1e1-1d69-4b49-9f30-683d55213ed6','f673e108-7ca0-4907-8b62-ebf3d56e91f6',0);

/* Datalayer values  */

INSERT INTO datalayer VALUES('2FF1840D-1B12-4CD1-B1BE-A8350890AAFF', false, now(), 'AAA21937-B504-4F42-81B1-81B496F919AF', 'CALFIRE Facilities (KML)', 't', 1);

INSERT INTO datalayer(usersessionid,created,datalayerid,baselayer,datalayersourceid,displayname,globalview) VALUES (1,now(),'c09cc1e1-1d69-4b49-9f30-683d55213ed6','t','0b79bd02-bf28-494d-aa2f-f2ce858d9db8','Data Legend','t');

INSERT INTO datalayer(usersessionid,created,datalayerid,baselayer,datalayersourceid,displayname,globalview) VALUES (1,now(),'16d3c7e8-dfa4-42aa-a25e-4c9dd01a0a75','t','62352220-c0f9-4652-a412-28e6b2fdaa95','Weather Legend','t');

/*  Datalayersource values */

INSERT INTO datalayersource VALUES('AAA21937-B504-4F42-81B1-81B496F919AF', now(), 'D09B9B86-008A-4032-A881-60CCF4A50916', 'image/png', '/CA7A9021-4C77-4533-B6CF-464850B82784.kml', 'EPSG:4326', 0, null, null, null, 1);

INSERT INTO datalayersource(created, datalayersourceid,datasourceid,refreshrate,usersessionid, opacity) VALUES (now(),'0b79bd02-bf28-494d-aa2f-f2ce858d9db8','D09B9B86-008A-4032-A881-60CCF4A50916',0,1,1);

INSERT INTO datalayersource(created,datalayersourceid,datasourceid,refreshrate,usersessionid, opacity) VALUES (now(),'62352220-c0f9-4652-a412-28e6b2fdaa95','D09B9B86-008A-4032-A881-60CCF4A50916',0,1,1);

Update datalayersource set opacity=1 where opacity IS NULL;