SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

/*-----------   Adding orcap*/

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
/*-----------   Adding cap*/

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
/*-----------   Adding datalayer_org */

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

/*-----------   Adding collabroomdatalayer*/

CREATE TABLE collabroomdatalayer (
    collabroomdatalayerid integer NOT NULL,
    collabroomid integer NOT NULL,
    datalayerid character varying(255) NOT NULL,
    userId character varying(255) NOT NULL
);

ALTER TABLE collabroomdatalayer OWNER TO nics;

/*-----------   Adding alert*/

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


/*-----------   Adding alertuser*/

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

/*-----------   Inserting missing values*/

INSERT INTO formtype VALUES (nextVal('form_seq'), 'GAR');
INSERT INTO formtype VALUES (nextVal('form_seq'), '201');
INSERT INTO formtype VALUES (nextVal('form_seq'), '202');
INSERT INTO formtype VALUES (nextVal('form_seq'), '203');
INSERT INTO formtype VALUES (nextVal('form_seq'), '204');
INSERT INTO formtype VALUES (nextVal('form_seq'), '205');
INSERT INTO formtype VALUES (nextVal('form_seq'), '206');


UPDATE folder set index = '0' where folderid='C6659C73-3BF2-4F7F-90AD-7EEFE9D4EEBA';

AlTER TABLE image add column fullpath character varying(250) NOT NULL;







