--
-- Copyright (c) 2008-2015, Massachusetts Institute of Technology (MIT)
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
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: assignment; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE assignment (
    unit_id bigint NOT NULL,
    operational_period_id bigint NOT NULL,
    published boolean DEFAULT false NOT NULL
);


ALTER TABLE assignment OWNER TO nics;

--
-- Name: chat; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE chat (
    chatid integer NOT NULL,
    collabroomid integer NOT NULL,
    userorgid integer NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    seqnum bigint,
    message text NOT NULL
);


ALTER TABLE chat OWNER TO nics;

--
-- Name: chat_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE chat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_seq OWNER TO nics;

--
-- Name: collab_room_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE collab_room_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE collab_room_seq OWNER TO nics;

--
-- Name: collabroom; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE collabroom (
    collabroomid integer NOT NULL,
    usersessionid integer NOT NULL,
    incidentid integer,
    name character varying(64) NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    bounds geometry,
    CONSTRAINT enforce_dims_bounds CHECK ((st_ndims(bounds) = 2)),
    CONSTRAINT enforce_geotype_bounds CHECK (((geometrytype(bounds) = 'POLYGON'::text) OR (bounds IS NULL))),
    CONSTRAINT enforce_srid_bounds CHECK ((st_srid(bounds) = 3857))
);


ALTER TABLE collabroom OWNER TO nics;

--
-- Name: collabroompermission; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE collabroompermission (
    collabroomid integer,
    userid integer,
    systemroleid integer,
    collabroompermissionid integer NOT NULL
);


ALTER TABLE collabroompermission OWNER TO nics;

--
-- Name: collabroom_permission_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE collabroom_permission_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE collabroom_permission_seq OWNER TO nics;

--
-- Name: collabroom_permission_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nics
--

ALTER SEQUENCE collabroom_permission_seq OWNED BY collabroompermission.collabroompermissionid;


--
-- Name: collabroomfeature; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE collabroomfeature (
    collabroomid integer NOT NULL,
    featureid bigint NOT NULL,
    collabroomfeatureid bigint NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE collabroomfeature OWNER TO nics;

--
-- Name: collabroomfeature_collabroomfeatureid_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE collabroomfeature_collabroomfeatureid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE collabroomfeature_collabroomfeatureid_seq OWNER TO nics;

--
-- Name: collabroomfeature_collabroomfeatureid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nics
--

ALTER SEQUENCE collabroomfeature_collabroomfeatureid_seq OWNED BY collabroomfeature.collabroomfeatureid;

--
-- Name: contact; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE contact (
    contactid integer NOT NULL,
    userid integer NOT NULL,
    contacttypeid integer NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    value character varying(64) NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    enablelogin boolean
);


ALTER TABLE contact OWNER TO nics;

--
-- Name: contact_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE contact_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contact_seq OWNER TO nics;

--
-- Name: contacttype; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE contacttype (
    contacttypeid integer NOT NULL,
    type character varying(20) NOT NULL
);


ALTER TABLE contacttype OWNER TO nics;

--
-- Name: currentusersession; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE currentusersession (
    currentusersessionid integer NOT NULL,
    usersessionid integer NOT NULL,
    userid integer NOT NULL,
    displayname character varying(64) NOT NULL,
    loggedin timestamp without time zone DEFAULT now() NOT NULL,
    lastseen timestamp without time zone DEFAULT now() NOT NULL,
    systemroleid integer NOT NULL,
    workspaceid integer
);


ALTER TABLE currentusersession OWNER TO nics;

--
-- Name: current_user_session_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE current_user_session_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE current_user_session_seq OWNER TO nics;

--
-- Name: current_user_session_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nics
--

ALTER SEQUENCE current_user_session_seq OWNED BY currentusersession.currentusersessionid;


--
-- Name: datalayer; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE datalayer (
    datalayerid character varying(255) NOT NULL,
    baselayer boolean NOT NULL,
    created timestamp without time zone NOT NULL,
    datalayersourceid character varying(255) NOT NULL,
    displayname character varying(256) NOT NULL,
    globalview boolean NOT NULL,
    usersessionid integer NOT NULL,
    legend character varying(256)
);


ALTER TABLE datalayer OWNER TO nics;

--
-- Name: datalayerfolder; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE datalayerfolder (
    datalayerfolderid integer NOT NULL,
    datalayerid character varying(255) NOT NULL,
    folderid character varying(255) NOT NULL,
    index integer NOT NULL
);


ALTER TABLE datalayerfolder OWNER TO nics;

--
-- Name: datalayerfolder_workspace; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE datalayerfolder_workspace (
    workspaceid integer NOT NULL,
    datalayerfolderid integer NOT NULL,
    datalayerfolder_workspace_id integer NOT NULL
);


ALTER TABLE datalayerfolder_workspace OWNER TO nics;

--
-- Name: datalayersource; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE datalayersource (
    datalayersourceid character varying(255) NOT NULL,
    created timestamp without time zone NOT NULL,
    datasourceid character varying(255) NOT NULL,
    imageformat character varying(64),
    layername character varying(256),
    nativeprojection character varying(64),
    refreshrate integer NOT NULL,
    stylepath character varying(128),
    tilegridset character varying(64),
    tilesize integer,
    usersessionid integer NOT NULL,
    opacity double precision,
    attributes character varying(1024)
);


ALTER TABLE datalayersource OWNER TO nics;

--
-- Name: datalayerstyle; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE datalayerstyle (
    datalayerstyleid integer NOT NULL,
    type character varying(20) NOT NULL,
    value character varying(255) NOT NULL,
    datalayerid character varying(255) NOT NULL
);


ALTER TABLE datalayerstyle OWNER TO nics;

--
-- Name: datasource; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE datasource (
    datasourceid character varying(255) NOT NULL,
    externalurl character varying(256),
    internalurl character varying(256) NOT NULL,
    datasourcetypeid integer,
    displayname character varying(256)
);


ALTER TABLE datasource OWNER TO nics;

--
-- Name: datasourcetype; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE datasourcetype (
    typename character varying(64) NOT NULL,
    datasourcetypeid integer NOT NULL
);


ALTER TABLE datasourcetype OWNER TO nics;

--
-- Name: document; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE document (
    documentid character varying(255) NOT NULL,
    created timestamp without time zone NOT NULL,
    datasourceid character varying(255),
    displayname character varying(256) NOT NULL,
    filetype character varying(256) NOT NULL,
    folderid character varying(255),
    globalview boolean NOT NULL,
    usersessionid integer NOT NULL,
    filename character varying(256),
    description character varying
);


ALTER TABLE document OWNER TO nics;

--
-- Name: document_collabroom; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE document_collabroom (
    document_collabroomid character varying(255) NOT NULL,
    collabroomid integer NOT NULL,
    documentid character varying(255) NOT NULL
);


ALTER TABLE document_collabroom OWNER TO nics;

--
-- Name: document_feature; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE document_feature (
    document_featureid integer NOT NULL,
    documentid character varying(255) NOT NULL,
    featureid bigint NOT NULL
);


ALTER TABLE document_feature OWNER TO nics;

--
-- Name: document_feature_document_featureid_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE document_feature_document_featureid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE document_feature_document_featureid_seq OWNER TO nics;

--
-- Name: document_feature_document_featureid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nics
--

ALTER SEQUENCE document_feature_document_featureid_seq OWNED BY document_feature.document_featureid;


--
-- Name: document_incident; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE document_incident (
    document_incidentid character varying(255) NOT NULL,
    documentid character varying(255) NOT NULL,
    incidentid integer NOT NULL
);


ALTER TABLE document_incident OWNER TO nics;

--
-- Name: document_org; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE document_org (
    document_orgid character varying(255) NOT NULL,
    documentid character varying(255) NOT NULL,
    orgid integer NOT NULL
);


ALTER TABLE document_org OWNER TO nics;

--
-- Name: document_user; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE document_user (
    document_userid character varying(255) NOT NULL,
    documentid character varying(255) NOT NULL,
    userid integer NOT NULL
);


ALTER TABLE document_user OWNER TO nics;

--
-- Name: feature; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE feature (
    usersessionid integer NOT NULL,
    strokecolor character varying(64),
    strokewidth double precision,
    fillcolor character varying(64),
    dashstyle character varying(32),
    opacity double precision,
    rotation double precision,
    graphic character varying(256),
    graphicheight double precision,
    graphicwidth double precision,
    hasgraphic boolean,
    labelsize double precision,
    labeltext character varying(100),
    username character varying(100) NOT NULL,
    nickname character varying(32),
    topic character varying(96),
    "time" character varying(24),
    version character varying(12),
    ip character varying(15),
    seqtime bigint,
    seqnum bigint,
    lastupdate timestamp without time zone DEFAULT now() NOT NULL,
    geometry geometry,
    featureid bigint NOT NULL,
    pointradius double precision,
    featuretype character varying(32),
    type character varying(32),
    attributes character varying(1024),
    CONSTRAINT enforce_dims_the_geom CHECK ((st_ndims(geometry) = 2)),
    CONSTRAINT enforce_srid_the_geom CHECK ((st_srid(geometry) = 3857))
);


ALTER TABLE feature OWNER TO nics;

--
-- Name: feature_featureid_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE feature_featureid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE feature_featureid_seq OWNER TO nics;

--
-- Name: feature_featureid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nics
--

ALTER SEQUENCE feature_featureid_seq OWNED BY feature.featureid;


--
-- Name: folder; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE folder (
    folderid character varying(255) NOT NULL,
    foldername character varying(256) NOT NULL,
    parentfolderid character varying(255),
    index integer,
    workspaceid integer
);


ALTER TABLE folder OWNER TO nics;


--
-- Name: form; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE form (
    formid integer NOT NULL,
    formtypeid integer NOT NULL,
    incidentid integer NOT NULL,
    usersessionid integer NOT NULL,
    seqtime bigint NOT NULL,
    seqnum bigint NOT NULL,
    message text NOT NULL,
    distributed boolean DEFAULT false,
    incidentname character varying(255)
);


ALTER TABLE form OWNER TO nics;

--
-- Name: form_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE form_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE form_seq OWNER TO nics;

--
-- Name: incident; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE incident (
    incidentid integer UNIQUE NOT NULL ,
    usersessionid integer,
    incidentname character varying(50) NOT NULL,
    lat double precision NOT NULL,
    lon double precision NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    active boolean DEFAULT true NOT NULL,
    folder character varying(50) DEFAULT ''::character varying NOT NULL,
    bounds geometry,
    lastupdate timestamp without time zone,
    workspaceid integer,
    description character varying(500),
    parentincidentid integer,
    CONSTRAINT enforce_dims_bounds CHECK ((st_ndims(bounds) = 2)),
    CONSTRAINT enforce_geotype_bounds CHECK (((geometrytype(bounds) = 'POLYGON'::text) OR (bounds IS NULL))),
    CONSTRAINT enforce_srid_bounds CHECK ((st_srid(bounds) = 3857))
);


ALTER TABLE incident OWNER TO nics;
--
-- Name: uxoreport_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE uxoreport_seq
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER TABLE uxoreport_seq OWNER TO nics;

--
-- Name: uxoreport; Type: TABLE: Schema: public: Owner: nics;
--
CREATE TABLE uxoreport (
    uxoreportid bigint DEFAULT nextval('uxoreport_seq'::regclass) NOT NULL,
    incidentid integer NOT NULL,
    message text NOT NULL,
    lat double precision NOT NULL,
    lon double precision not null,
  CONSTRAINT pk_uxoreport primary key (uxoreportid),
  CONSTRAINT fk_incident foreign key (incidentid)
    references incident (incidentid) match simple
);

ALTER TABLE uxoreport OWNER TO nics;

--
-- Name: formtype; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE formtype (
    formtypeid integer NOT NULL,
    formtypename character varying(60) NOT NULL
);


ALTER TABLE formtype OWNER TO nics;

--
-- Name: gisparametertype; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE gisparametertype (
    parametertypeid character varying(200) NOT NULL,
    parametername character varying(64) NOT NULL
);


ALTER TABLE gisparametertype OWNER TO nics;

--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hibernate_sequence OWNER TO nics;

--
-- Name: ics_position; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE ics_position (
    code integer NOT NULL,
    name character varying(10),
    pos_type character varying(10),
    description character varying(60)
);


ALTER TABLE ics_position OWNER TO nics;

--
-- Name: image_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE image_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE image_seq OWNER TO nics;

--
-- Name: image; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE image (
    id bigint DEFAULT nextval('image_seq'::regclass) NOT NULL,
    location_id integer NOT NULL,
    incident_id integer NOT NULL,
    url character varying(250) NOT NULL
);


ALTER TABLE image OWNER TO nics;

--
-- Name: incident_incidenttype; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE incident_incidenttype (
    incident_incidenttypeid integer NOT NULL,
    incidentid integer NOT NULL,
    incidenttypeid integer
);


ALTER TABLE incident_incidenttype OWNER TO nics;

--
-- Name: incident_incidenttype_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE incident_incidenttype_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE incident_incidenttype_seq OWNER TO nics;

--
-- Name: incident_incidenttype_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nics
--

ALTER SEQUENCE incident_incidenttype_seq OWNED BY incident_incidenttype.incident_incidenttypeid;


--
-- Name: incident_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE incident_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE incident_seq OWNER TO nics;

--
-- Name: incident_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nics
--

ALTER SEQUENCE incident_seq OWNED BY incident.incidentid;


--
-- Name: incidenttype; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE incidenttype (
    incidenttypeid integer NOT NULL,
    incidenttypename character varying(45) NOT NULL
);


ALTER TABLE incidenttype OWNER TO nics;

--
-- Name: location_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE location_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE location_seq OWNER TO nics;

--
-- Name: location; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE location (
    id bigint DEFAULT nextval('location_seq'::regclass) NOT NULL,
    user_id integer,
    device_id character varying(250) NOT NULL,
    location geometry NOT NULL,
    accuracy double precision,
    course double precision,
    speed double precision,
    "time" bigint NOT NULL,
    CONSTRAINT enforce_dims_loc_location CHECK ((st_ndims(location) = 3)),
    CONSTRAINT enforce_geotype_loc_location CHECK ((geometrytype(location) = 'POINT'::text)),
    CONSTRAINT enforce_srid_loc_location CHECK ((st_srid(location) = 4326))
);


ALTER TABLE location OWNER TO nics;

--
-- Name: log; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE log (
    logid integer NOT NULL,
    logtypeid integer NOT NULL,
    usersessionid integer,
    message text,
    created timestamp without time zone DEFAULT now() NOT NULL,
    status integer
);


ALTER TABLE log OWNER TO nics;

--
-- Name: log_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE log_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE log_seq OWNER TO nics;

--
-- Name: log_workspace; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE log_workspace (
    workspaceid integer NOT NULL,
    logid integer NOT NULL,
    log_workspace_id integer NOT NULL
);


ALTER TABLE log_workspace OWNER TO nics;

--
-- Name: logtype; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE logtype (
    logtypeid integer NOT NULL,
    name character varying(20)
);


ALTER TABLE logtype OWNER TO nics;

--
-- Name: message_archive_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE message_archive_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE message_archive_seq OWNER TO nics;

--
-- Name: message_sequence; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE message_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE;


ALTER TABLE message_sequence OWNER TO nics;

--
-- Name: messagearchive; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE messagearchive (
    messagearchiveid integer NOT NULL,
    topic character varying(96) NOT NULL,
    clienttimestamp timestamp without time zone NOT NULL,
    insertedtimestamp timestamp without time zone DEFAULT now() NOT NULL,
    "user" character varying(32) NOT NULL,
    messagetype character varying(32) NOT NULL,
    message text NOT NULL,
    seqtime bigint NOT NULL,
    seqnum bigint NOT NULL
);


ALTER TABLE messagearchive OWNER TO nics;

--
-- Name: messagepermissions; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE messagepermissions (
    systemroleid integer NOT NULL,
    messagetype character varying(50)
);


ALTER TABLE messagepermissions OWNER TO nics;

--
-- Name: nicssystem; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE nicssystem (
    systemid integer NOT NULL,
    systemname character varying NOT NULL,
    description character varying(100),
    enabled boolean
);


ALTER TABLE nicssystem OWNER TO nics;

--
-- Name: operational_period_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE operational_period_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE operational_period_seq OWNER TO nics;

--
-- Name: operational_period; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE operational_period (
    id bigint DEFAULT nextval('operational_period_seq'::regclass) NOT NULL,
    incident_id integer NOT NULL,
    start_utc bigint NOT NULL,
    end_utc bigint NOT NULL
);


ALTER TABLE operational_period OWNER TO nics;

--
-- Name: options; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE options (
    optionsid integer NOT NULL,
    localhost character varying(100) NOT NULL,
    geoserverhost character varying(100) DEFAULT 'localhost'::character varying NOT NULL,
    geoserverport integer DEFAULT 8051 NOT NULL,
    openfirehost character varying(100) DEFAULT 'localhost'::character varying NOT NULL,
    openfireport integer DEFAULT 5223 NOT NULL,
    showtest smallint DEFAULT (0)::smallint NOT NULL,
    target character varying(4) DEFAULT 'dev'::character varying NOT NULL,
    logtojboss smallint DEFAULT (1)::smallint NOT NULL,
    name character varying(65) DEFAULT 'Situational Awareness Display'::character varying NOT NULL,
    version character varying(32) NOT NULL,
    footer character varying(100) DEFAULT 'Situational Awareness Display'::character varying NOT NULL
);


ALTER TABLE options OWNER TO nics;

--
-- Name: org; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE org (
    orgid integer NOT NULL,
    name character varying(100) NOT NULL,
    county character varying(35) DEFAULT NULL::character varying,
    state character varying(2) DEFAULT NULL::character varying,
    timezone character varying(100) DEFAULT NULL::character varying,
    prefix character varying(24) NOT NULL,
    distribution character varying(1024) DEFAULT NULL::character varying,
    defaultlatitude double precision NOT NULL,
    defaultlongitude double precision NOT NULL,
    parentorgid integer,
    country character varying(30),
    created timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE org OWNER TO nics;

--
-- Name: org_formtype_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE org_formtype_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE org_formtype_seq OWNER TO nics;

--
-- Name: org_orgtype; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE org_orgtype (
    org_orgtypeid integer NOT NULL,
    orgid integer NOT NULL,
    orgtypeid integer
);


ALTER TABLE org_orgtype OWNER TO nics;

--
-- Name: org_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE org_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE org_seq OWNER TO nics;

--
-- Name: orgfolder; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE orgfolder (
    orgfolderid integer NOT NULL,
    orgid integer NOT NULL,
    folderid character varying(250) NOT NULL
);


ALTER TABLE orgfolder OWNER TO nics;

--
-- Name: orgformtype; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE orgformtype (
    orgformtypeid integer NOT NULL,
    orgid integer NOT NULL,
    formtypeid integer NOT NULL
);


ALTER TABLE orgformtype OWNER TO nics;

--
-- Name: orgtype; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE orgtype (
    orgtypeid integer NOT NULL,
    orgtypename character varying(45) NOT NULL
);


ALTER TABLE orgtype OWNER TO nics;

--
-- Name: resource_assign_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE resource_assign_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE resource_assign_seq OWNER TO nics;

--
-- Name: resource_assign; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE resource_assign (
    id bigint DEFAULT nextval('resource_assign_seq'::regclass) NOT NULL,
    user_id integer NOT NULL,
    unit_id bigint NOT NULL,
    operational_period_id bigint NOT NULL,
    leader boolean DEFAULT false NOT NULL
);


ALTER TABLE resource_assign OWNER TO nics;

--
-- Name: rootfolder; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE rootfolder (
    rootid character varying(255) NOT NULL,
    folderid character varying(255),
    tabname character varying(256) NOT NULL,
    workspaceid integer
);


ALTER TABLE rootfolder OWNER TO nics;

--
-- Name: seq; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE seq (
    name character varying(96) NOT NULL,
    val integer
);


ALTER TABLE seq OWNER TO nics;

--
-- Name: system_workspace; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE system_workspace (
    system_workspace_id integer NOT NULL,
    systemid integer NOT NULL,
    workspaceid integer NOT NULL
);

ALTER TABLE system_workspace OWNER TO nics;


--
-- Name: systemrole; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE systemrole (
    systemroleid integer NOT NULL,
    rolename character varying(32) NOT NULL
);


ALTER TABLE systemrole OWNER TO nics;

--
-- Name: systemrole_workspace; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE systemrole_workspace (
    workspaceid integer NOT NULL,
    systemroleid integer NOT NULL,
    systemrole_workspace_id integer NOT NULL,
    features character varying(300)
);


ALTER TABLE systemrole_workspace OWNER TO nics;

--
-- Name: task_assign_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE task_assign_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE task_assign_seq OWNER TO nics;

--
-- Name: task_assign; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE task_assign (
    id bigint DEFAULT nextval('task_assign_seq'::regclass) NOT NULL,
    unit_id bigint NOT NULL,
    operational_period_id bigint NOT NULL,
    form_id integer NOT NULL,
    completed boolean DEFAULT false NOT NULL
);


ALTER TABLE task_assign OWNER TO nics;

--
-- Name: unit_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE unit_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE unit_seq OWNER TO nics;

--
-- Name: unit; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE unit (
    id bigint DEFAULT nextval('unit_seq'::regclass) NOT NULL,
    incident_id integer NOT NULL,
    unitname text NOT NULL,
    collabroom_id integer NOT NULL
);


ALTER TABLE unit OWNER TO nics;

--
-- Name: user; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE "user" (
    userid integer NOT NULL,
    username character varying(100) NOT NULL,
    passwordhash character varying(65) NOT NULL,
    firstname character varying(20) DEFAULT NULL::character varying,
    lastname character varying(64) DEFAULT NULL::character varying,
    lastupdated timestamp without time zone DEFAULT now() NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    passwordencrypted bytea,
    active boolean,
    passwordchanged timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE "user" OWNER TO nics;

--
-- Name: user_info; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE user_info (
    user_id integer NOT NULL,
    rank character varying(50),
    primary_mobile_phone character varying(15),
    primary_home_phone character varying(15),
    primary_email_addr character varying(320),
    home_base_name character varying(30),
    home_base_street character varying(30),
    home_base_city character varying(25),
    home_base_state character varying(15),
    home_base_zip character varying(10),
    agency character varying(30),
    approx_weight integer DEFAULT 0 NOT NULL,
    remarks character varying(60),
    creation_date_time bigint NOT NULL
);


ALTER TABLE user_info OWNER TO nics;

--
-- Name: user_info_ics_position; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE user_info_ics_position (
    user_id integer NOT NULL,
    code integer NOT NULL
);


ALTER TABLE user_info_ics_position OWNER TO nics;

--
-- Name: user_org_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE user_org_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_org_seq OWNER TO nics;

--
-- Name: user_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_seq OWNER TO nics;

--
-- Name: usersession; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE usersession (
    usersessionid integer NOT NULL,
    userorgid integer NOT NULL,
    sessionid character varying(128) NOT NULL,
    loggedin timestamp without time zone DEFAULT now() NOT NULL,
    loggedout timestamp without time zone DEFAULT now()
);


ALTER TABLE usersession OWNER TO nics;

--
-- Name: user_session_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE user_session_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_session_seq OWNER TO nics;

--
-- Name: user_session_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nics
--

ALTER SEQUENCE user_session_seq OWNED BY usersession.usersessionid;


--
-- Name: userfeature; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE userfeature (
    userfeatureid bigint NOT NULL,
    featureid bigint NOT NULL,
    userid integer NOT NULL,
    workspaceid integer,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE userfeature OWNER TO nics;

--
-- Name: userfeature_userfeatureid_seq; Type: SEQUENCE; Schema: public; Owner: nics
--

CREATE SEQUENCE userfeature_userfeatureid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userfeature_userfeatureid_seq OWNER TO nics;

--
-- Name: userfeature_userfeatureid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nics
--

ALTER SEQUENCE userfeature_userfeatureid_seq OWNED BY userfeature.userfeatureid;


--
-- Name: userorg; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE userorg (
    userorgid integer NOT NULL,
    userid integer NOT NULL,
    orgid integer NOT NULL,
    systemroleid integer NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    unit character varying(128),
    rank character varying(128),
    description character varying(250),
    jobtitle character varying(128)
);


ALTER TABLE userorg OWNER TO nics;

--
-- Name: userorg_workspace; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE userorg_workspace (
    workspaceid integer NOT NULL,
    userorgid integer NOT NULL,
    userorg_workspace_id integer NOT NULL,
    enabled boolean NOT NULL,
    defaultorg boolean
);


ALTER TABLE userorg_workspace OWNER TO nics;

--
-- Name: workspace; Type: TABLE; Schema: public; Owner: nics; Tablespace: 
--

CREATE TABLE workspace (
    workspaceid integer NOT NULL,
    workspacename character varying(100) NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE workspace OWNER TO nics;

--
-- Name: collabroomfeatureid; Type: DEFAULT; Schema: public; Owner: nics
--

ALTER TABLE ONLY collabroomfeature ALTER COLUMN collabroomfeatureid SET DEFAULT nextval('collabroomfeature_collabroomfeatureid_seq'::regclass);


--
-- Name: collabroompermissionid; Type: DEFAULT; Schema: public; Owner: nics
--

ALTER TABLE ONLY collabroompermission ALTER COLUMN collabroompermissionid SET DEFAULT nextval('collabroom_permission_seq'::regclass);


--
-- Name: currentusersessionid; Type: DEFAULT; Schema: public; Owner: nics
--

ALTER TABLE ONLY currentusersession ALTER COLUMN currentusersessionid SET DEFAULT nextval('current_user_session_seq'::regclass);


--
-- Name: document_featureid; Type: DEFAULT; Schema: public; Owner: nics
--

ALTER TABLE ONLY document_feature ALTER COLUMN document_featureid SET DEFAULT nextval('document_feature_document_featureid_seq'::regclass);


--
-- Name: featureid; Type: DEFAULT; Schema: public; Owner: nics
--

ALTER TABLE ONLY feature ALTER COLUMN featureid SET DEFAULT nextval('feature_featureid_seq'::regclass);


--
-- Name: incidentid; Type: DEFAULT; Schema: public; Owner: nics
--

ALTER TABLE ONLY incident ALTER COLUMN incidentid SET DEFAULT nextval('incident_seq'::regclass);


--
-- Name: logid; Type: DEFAULT: SChema: public;
--
ALTER TABLE ONLY log ALTER COLUMN logid SET DEFAULT nextval('log_seq'::regclass);


--
-- Name: incident_incidenttypeid; Type: DEFAULT; Schema: public;
--

ALTER TABLE ONLY incident_incidenttype ALTER COLUMN incident_incidenttypeid SET DEFAULT nextval('incident_incidenttype_seq'::regclass);


--
-- Name: userfeatureid; Type: DEFAULT; Schema: public; Owner: nics
--

ALTER TABLE ONLY userfeature ALTER COLUMN userfeatureid SET DEFAULT nextval('userfeature_userfeatureid_seq'::regclass);


--
-- Name: usersessionid; Type: DEFAULT; Schema: public; Owner: nics
--

ALTER TABLE ONLY usersession ALTER COLUMN usersessionid SET DEFAULT nextval('user_session_seq'::regclass);


--
-- Name: assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY assignment
    ADD CONSTRAINT assignment_pkey PRIMARY KEY (unit_id, operational_period_id);


--
-- Name: chat_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY chat
    ADD CONSTRAINT chat_pkey PRIMARY KEY (chatid);


--
-- Name: collabroom_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY collabroom
    ADD CONSTRAINT collabroom_pkey PRIMARY KEY (collabroomid);


--
-- Name: collabroomfeature_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY collabroomfeature
    ADD CONSTRAINT collabroomfeature_pkey PRIMARY KEY (collabroomfeatureid);


--
-- Name: collabroompermission_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY collabroompermission
    ADD CONSTRAINT collabroompermission_pkey PRIMARY KEY (collabroompermissionid);


--
-- Name: contact_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (contactid);


--
-- Name: contacttype_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY contacttype
    ADD CONSTRAINT contacttype_pkey PRIMARY KEY (contacttypeid);


--
-- Name: currentusersession_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY currentusersession
    ADD CONSTRAINT currentusersession_pkey PRIMARY KEY (currentusersessionid);


--
-- Name: currentusersession_userid_key; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY currentusersession
    ADD CONSTRAINT currentusersession_userid_key UNIQUE (userid);


--
-- Name: datalayer_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY datalayer
    ADD CONSTRAINT datalayer_pkey PRIMARY KEY (datalayerid);


--
-- Name: datalayerfolder_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY datalayerfolder
    ADD CONSTRAINT datalayerfolder_pkey PRIMARY KEY (datalayerfolderid);


--
-- Name: datalayerfolder_workspace_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY datalayerfolder_workspace
    ADD CONSTRAINT datalayerfolder_workspace_pkey PRIMARY KEY (datalayerfolder_workspace_id);


--
-- Name: datalayersource_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY datalayersource
    ADD CONSTRAINT datalayersource_pkey PRIMARY KEY (datalayersourceid);


--
-- Name: datasource_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY datasource
    ADD CONSTRAINT datasource_pkey PRIMARY KEY (datasourceid);


--
-- Name: datasourcetype_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY datasourcetype
    ADD CONSTRAINT datasourcetype_pkey PRIMARY KEY (datasourcetypeid);


--
-- Name: document_collabroom_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY document_collabroom
    ADD CONSTRAINT document_collabroom_pkey PRIMARY KEY (document_collabroomid);


--
-- Name: document_feature_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY document_feature
    ADD CONSTRAINT document_feature_pkey PRIMARY KEY (document_featureid);


--
-- Name: document_incident_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY document_incident
    ADD CONSTRAINT document_incident_pkey PRIMARY KEY (document_incidentid);


--
-- Name: document_org_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY document_org
    ADD CONSTRAINT document_org_pkey PRIMARY KEY (document_orgid);


--
-- Name: document_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY document
    ADD CONSTRAINT document_pkey PRIMARY KEY (documentid);


--
-- Name: document_user_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY document_user
    ADD CONSTRAINT document_user_pkey PRIMARY KEY (document_userid);


--
-- Name: feature_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY feature
    ADD CONSTRAINT feature_pkey PRIMARY KEY (featureid);


--
-- Name: folder_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY folder
    ADD CONSTRAINT folder_pkey PRIMARY KEY (folderid);


--
-- Name: form_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY form
    ADD CONSTRAINT form_pkey PRIMARY KEY (formid);


--
-- Name: formtype_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY formtype
    ADD CONSTRAINT formtype_pkey PRIMARY KEY (formtypeid);


--
-- Name: gisparametertype_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY gisparametertype
    ADD CONSTRAINT gisparametertype_pkey PRIMARY KEY (parametertypeid);


--
-- Name: ics_position_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY ics_position
    ADD CONSTRAINT ics_position_pkey PRIMARY KEY (code);


--
-- Name: image_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);


--
-- Name: incident_incidenttype_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY incident_incidenttype
    ADD CONSTRAINT incident_incidenttype_pkey PRIMARY KEY (incident_incidenttypeid);


--
-- Name: incident_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY incident
    ADD CONSTRAINT incident_pkey PRIMARY KEY (incidentid);


--
-- Name: incidenttype_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY incidenttype
    ADD CONSTRAINT incidenttype_pkey PRIMARY KEY (incidenttypeid);


--
-- Name: layerstyle_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY datalayerstyle
    ADD CONSTRAINT layerstyle_pkey PRIMARY KEY (datalayerstyleid);


--
-- Name: location_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_pkey PRIMARY KEY (id);


--
-- Name: log_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY log
    ADD CONSTRAINT log_pkey PRIMARY KEY (logid);


--
-- Name: log_workspace_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY log_workspace
    ADD CONSTRAINT log_workspace_pkey PRIMARY KEY (log_workspace_id);


--
-- Name: logtype_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY logtype
    ADD CONSTRAINT logtype_pkey PRIMARY KEY (logtypeid);


--
-- Name: messagearchive_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY messagearchive
    ADD CONSTRAINT messagearchive_pkey PRIMARY KEY (messagearchiveid);


--
-- Name: operational_period_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY operational_period
    ADD CONSTRAINT operational_period_pkey PRIMARY KEY (id);


--
-- Name: options_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY options
    ADD CONSTRAINT options_pkey PRIMARY KEY (optionsid);


--
-- Name: org_orgtype_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY org_orgtype
    ADD CONSTRAINT org_orgtype_pkey PRIMARY KEY (org_orgtypeid);


--
-- Name: org_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY org
    ADD CONSTRAINT org_pkey PRIMARY KEY (orgid);


--
-- Name: orgformtype_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY orgformtype
    ADD CONSTRAINT orgformtype_pkey PRIMARY KEY (orgformtypeid);


--
-- Name: orgtype_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY orgtype
    ADD CONSTRAINT orgtype_pkey PRIMARY KEY (orgtypeid);


--
-- Name: resource_assign_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY resource_assign
    ADD CONSTRAINT resource_assign_pkey PRIMARY KEY (id);


--
-- Name: resource_operational_period_key; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY resource_assign
    ADD CONSTRAINT resource_operational_period_key UNIQUE (user_id, operational_period_id);


--
-- Name: rootfolder_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY rootfolder
    ADD CONSTRAINT rootfolder_pkey PRIMARY KEY (rootid);


--
-- Name: seq_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY seq
    ADD CONSTRAINT seq_pkey PRIMARY KEY (name);


--
-- Name: system_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY nicssystem
    ADD CONSTRAINT system_pkey PRIMARY KEY (systemid);


--
-- Name: systemrole_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY systemrole
    ADD CONSTRAINT systemrole_pkey PRIMARY KEY (systemroleid);


--
-- Name: systemrole_workspace_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY systemrole_workspace
    ADD CONSTRAINT systemrole_workspace_pkey PRIMARY KEY (systemrole_workspace_id);


--
-- Name: task_assign_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY task_assign
    ADD CONSTRAINT task_assign_pkey PRIMARY KEY (id);


--
-- Name: unit_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY unit
    ADD CONSTRAINT unit_pkey PRIMARY KEY (id);


--
-- Name: user_info_ics_position_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY user_info_ics_position
    ADD CONSTRAINT user_info_ics_position_pkey PRIMARY KEY (user_id, code);


--
-- Name: user_info_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY user_info
    ADD CONSTRAINT user_info_pkey PRIMARY KEY (user_id);


--
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (userid);


--
-- Name: userfeature_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY userfeature
    ADD CONSTRAINT userfeature_pkey PRIMARY KEY (userfeatureid);


--
-- Name: userorg_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY userorg
    ADD CONSTRAINT userorg_pkey PRIMARY KEY (userorgid);


--
-- Name: userorg_workspace_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY userorg_workspace
    ADD CONSTRAINT userorg_workspace_pkey PRIMARY KEY (userorg_workspace_id);


--
-- Name: usersession_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY usersession
    ADD CONSTRAINT usersession_pkey PRIMARY KEY (usersessionid);


--
-- Name: workspace_pkey; Type: CONSTRAINT; Schema: public; Owner: nics; Tablespace: 
--

ALTER TABLE ONLY workspace
    ADD CONSTRAINT workspace_pkey PRIMARY KEY (workspaceid);


--
-- Name: collabroom_gist; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX collabroom_gist ON collabroom USING gist (bounds);


--
-- Name: collabroom_usersession; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX collabroom_usersession ON collabroom USING btree (usersessionid);


--
-- Name: feature_gist; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX feature_gist ON feature USING gist (geometry);


--
-- Name: fk_chat_collabroom; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_chat_collabroom ON chat USING btree (collabroomid);


--
-- Name: fk_chat_userorg; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_chat_userorg ON chat USING btree (userorgid);


--
-- Name: fk_collabstate_usersession; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_collabstate_usersession ON feature USING btree (usersessionid);


--
-- Name: fk_contact_contacttype; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_contact_contacttype ON contact USING btree (contacttypeid);


--
-- Name: fk_contact_user; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_contact_user ON contact USING btree (userid);


--
-- Name: fk_current_usersession_usersession; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_current_usersession_usersession ON currentusersession USING btree (usersessionid);


--
-- Name: fk_datalayer_usersession; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_datalayer_usersession ON datalayer USING btree (usersessionid);


--
-- Name: fk_datalayersource_datasource; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_datalayersource_datasource ON datalayersource USING btree (datasourceid);


--
-- Name: fk_datalayersource_usersessionid; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_datalayersource_usersessionid ON datalayersource USING btree (usersessionid);


--
-- Name: fk_form_incidentid; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_form_incidentid ON form USING btree (incidentid);


--
-- Name: fk_incident; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_incident ON incident_incidenttype USING btree (incidentid);


--
-- Name: fk_incident_usersession; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_incident_usersession ON incident USING btree (usersessionid);


--
-- Name: fk_incidenttype; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_incidenttype ON incident_incidenttype USING btree (incidenttypeid);


--
-- Name: fk_log_logtype; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_log_logtype ON log USING btree (logtypeid);


--
-- Name: fk_log_usersession; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_log_usersession ON log USING btree (usersessionid);


--
-- Name: fk_org; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_org ON org_orgtype USING btree (orgid);


--
-- Name: fk_orgtype; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_orgtype ON org_orgtype USING btree (orgtypeid);


--
-- Name: fk_rootfolder_folder; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_rootfolder_folder ON rootfolder USING btree (folderid);


--
-- Name: fk_userorg_org; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_userorg_org ON userorg USING btree (orgid);


--
-- Name: fk_userorg_user; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_userorg_user ON userorg USING btree (userid);


--
-- Name: fk_usersession_userorg; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX fk_usersession_userorg ON usersession USING btree (userorgid);


--
-- Name: incident_gist; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX incident_gist ON incident USING gist (bounds);


--
-- Name: incidentid; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX incidentid ON collabroom USING btree (incidentid);


--
-- Name: messagearchive_topic_idx; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE INDEX messagearchive_topic_idx ON messagearchive USING btree (topic);


--
-- Name: topic_idx; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE UNIQUE INDEX topic_idx ON seq USING btree (name);


--
-- Name: uname_idx; Type: INDEX; Schema: public; Owner: nics; Tablespace: 
--

CREATE UNIQUE INDEX uname_idx ON "user" USING btree (username);


--
-- Name: assignment_operational_period_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY assignment
    ADD CONSTRAINT assignment_operational_period_id_fkey FOREIGN KEY (operational_period_id) REFERENCES operational_period(id) ON DELETE CASCADE;


--
-- Name: assignment_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY assignment
    ADD CONSTRAINT assignment_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES unit(id) ON DELETE CASCADE;


--
-- Name: chat_collabroomid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY chat
    ADD CONSTRAINT chat_collabroomid_fkey FOREIGN KEY (collabroomid) REFERENCES collabroom(collabroomid);


--
-- Name: chat_userorgid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY chat
    ADD CONSTRAINT chat_userorgid_fkey FOREIGN KEY (userorgid) REFERENCES userorg(userorgid);


--
-- Name: collabroom_incidentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY collabroom
    ADD CONSTRAINT collabroom_incidentid_fkey FOREIGN KEY (incidentid) REFERENCES incident(incidentid);


--
-- Name: collabroom_permission_collabroomid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY collabroompermission
    ADD CONSTRAINT collabroom_permission_collabroomid_fkey FOREIGN KEY (collabroomid) REFERENCES collabroom(collabroomid);


--
-- Name: collabroom_permission_systemroleid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY collabroompermission
    ADD CONSTRAINT collabroom_permission_systemroleid_fkey FOREIGN KEY (systemroleid) REFERENCES systemrole(systemroleid);


--
-- Name: collabroom_permission_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY collabroompermission
    ADD CONSTRAINT collabroom_permission_userid_fkey FOREIGN KEY (userid) REFERENCES "user"(userid);


--
-- Name: collabroom_usersessionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY collabroom
    ADD CONSTRAINT collabroom_usersessionid_fkey FOREIGN KEY (usersessionid) REFERENCES usersession(usersessionid);


--
-- Name: contact_contacttypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact_contacttypeid_fkey FOREIGN KEY (contacttypeid) REFERENCES contacttype(contacttypeid);


--
-- Name: contact_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact_userid_fkey FOREIGN KEY (userid) REFERENCES "user"(userid);


--
-- Name: currentusersession_systemroleid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY currentusersession
    ADD CONSTRAINT currentusersession_systemroleid_fkey FOREIGN KEY (systemroleid) REFERENCES systemrole(systemroleid);


--
-- Name: currentusersession_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY currentusersession
    ADD CONSTRAINT currentusersession_userid_fkey FOREIGN KEY (userid) REFERENCES "user"(userid);


--
-- Name: currentusersession_usersessionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY currentusersession
    ADD CONSTRAINT currentusersession_usersessionid_fkey FOREIGN KEY (usersessionid) REFERENCES usersession(usersessionid);


--
-- Name: currentusersession_workspaceid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY currentusersession
    ADD CONSTRAINT currentusersession_workspaceid_fkey FOREIGN KEY (workspaceid) REFERENCES workspace(workspaceid);


--
-- Name: datalayerfolder_datalayerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY datalayerfolder
    ADD CONSTRAINT datalayerfolder_datalayerid_fkey FOREIGN KEY (datalayerid) REFERENCES datalayer(datalayerid);


--
-- Name: datalayerfolder_folderid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY datalayerfolder
    ADD CONSTRAINT datalayerfolder_folderid_fkey FOREIGN KEY (folderid) REFERENCES folder(folderid);


--
-- Name: datlayerfolder_workspaceid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY datalayerfolder_workspace
    ADD CONSTRAINT datlayerfolder_workspaceid_fkey FOREIGN KEY (workspaceid) REFERENCES workspace(workspaceid);


--
-- Name: documentid; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY document_feature
    ADD CONSTRAINT documentid FOREIGN KEY (documentid) REFERENCES document(documentid);


--
-- Name: feature_usersessionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY feature
    ADD CONSTRAINT feature_usersessionid_fkey FOREIGN KEY (usersessionid) REFERENCES usersession(usersessionid);


--
-- Name: featureid; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY document_feature
    ADD CONSTRAINT featureid FOREIGN KEY (featureid) REFERENCES feature(featureid);


--
-- Name: fk335cd11b9580bd29; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY document
    ADD CONSTRAINT fk335cd11b9580bd29 FOREIGN KEY (folderid) REFERENCES folder(folderid);


--
-- Name: fk335cd11bb62cd586; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY document
    ADD CONSTRAINT fk335cd11bb62cd586 FOREIGN KEY (usersessionid) REFERENCES usersession(usersessionid);


--
-- Name: fk335cd11bc9b72217; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY document
    ADD CONSTRAINT fk335cd11bc9b72217 FOREIGN KEY (datasourceid) REFERENCES datasource(datasourceid);


--
-- Name: fk514b80c17c70f16; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY document_collabroom
    ADD CONSTRAINT fk514b80c17c70f16 FOREIGN KEY (collabroomid) REFERENCES collabroom(collabroomid);


--
-- Name: fk514b80c5ad9cac3; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY document_collabroom
    ADD CONSTRAINT fk514b80c5ad9cac3 FOREIGN KEY (documentid) REFERENCES document(documentid);


--
-- Name: fk57743ebfdb88f93; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY datalayerfolder_workspace
    ADD CONSTRAINT fk57743ebfdb88f93 FOREIGN KEY (datalayerfolderid) REFERENCES datalayerfolder(datalayerfolderid);


--
-- Name: fk5e824c6f5ad9cac3; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY document_user
    ADD CONSTRAINT fk5e824c6f5ad9cac3 FOREIGN KEY (documentid) REFERENCES document(documentid);


--
-- Name: fk5e824c6fe105c53c; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY document_user
    ADD CONSTRAINT fk5e824c6fe105c53c FOREIGN KEY (userid) REFERENCES "user"(userid);


--
-- Name: fk7602bec2b62cd586; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY datalayersource
    ADD CONSTRAINT fk7602bec2b62cd586 FOREIGN KEY (usersessionid) REFERENCES usersession(usersessionid);


--
-- Name: fk7602bec2c9b72217; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY datalayersource
    ADD CONSTRAINT fk7602bec2c9b72217 FOREIGN KEY (datasourceid) REFERENCES datasource(datasourceid);


--
-- Name: fk82737045af27c0b; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY datasource
    ADD CONSTRAINT fk82737045af27c0b FOREIGN KEY (datasourcetypeid) REFERENCES datasourcetype(datasourcetypeid);


--
-- Name: fk97d1b3765ad9cac3; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY document_incident
    ADD CONSTRAINT fk97d1b3765ad9cac3 FOREIGN KEY (documentid) REFERENCES document(documentid);


--
-- Name: fk97d1b376ba39b40a; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY document_incident
    ADD CONSTRAINT fk97d1b376ba39b40a FOREIGN KEY (incidentid) REFERENCES incident(incidentid);


--
-- Name: fk_collabroomfeature_collabroomid; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY collabroomfeature
    ADD CONSTRAINT fk_collabroomfeature_collabroomid FOREIGN KEY (collabroomid) REFERENCES collabroom(collabroomid);


--
-- Name: fk_collabroomfeature_featureid; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY collabroomfeature
    ADD CONSTRAINT fk_collabroomfeature_featureid FOREIGN KEY (featureid) REFERENCES feature(featureid);


--
-- Name: fk_folderid; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY orgfolder
    ADD CONSTRAINT fk_folderid FOREIGN KEY (folderid) REFERENCES folder(folderid);


--
-- Name: fk_orgid; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY orgfolder
    ADD CONSTRAINT fk_orgid FOREIGN KEY (orgid) REFERENCES org(orgid);


--
-- Name: fk_systemroleid; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY messagepermissions
    ADD CONSTRAINT fk_systemroleid FOREIGN KEY (systemroleid) REFERENCES systemrole(systemroleid);


--
-- Name: fk_userfeature_featureid; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY userfeature
    ADD CONSTRAINT fk_userfeature_featureid FOREIGN KEY (featureid) REFERENCES feature(featureid);


--
-- Name: fk_userfeature_userid; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY userfeature
    ADD CONSTRAINT fk_userfeature_userid FOREIGN KEY (userid) REFERENCES "user"(userid);


--
-- Name: fk_userfeature_workspaceid; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY userfeature
    ADD CONSTRAINT fk_userfeature_workspaceid FOREIGN KEY (workspaceid) REFERENCES workspace(workspaceid);


--
-- Name: fka835a9c05ad9cac3; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY document_org
    ADD CONSTRAINT fka835a9c05ad9cac3 FOREIGN KEY (documentid) REFERENCES document(documentid);


--
-- Name: fka835a9c072480538; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY document_org
    ADD CONSTRAINT fka835a9c072480538 FOREIGN KEY (orgid) REFERENCES org(orgid);


--
-- Name: fkb45d1c6e18157bd3; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY folder
    ADD CONSTRAINT fkb45d1c6e18157bd3 FOREIGN KEY (parentfolderid) REFERENCES folder(folderid);


--
-- Name: fkc9b2ebd09580bd29; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY rootfolder
    ADD CONSTRAINT fkc9b2ebd09580bd29 FOREIGN KEY (folderid) REFERENCES folder(folderid);


--
-- Name: fkeb061fe76a7aefad; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY datalayer
    ADD CONSTRAINT fkeb061fe76a7aefad FOREIGN KEY (datalayersourceid) REFERENCES datalayersource(datalayersourceid);


--
-- Name: fkeb061fe7b62cd586; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY datalayer
    ADD CONSTRAINT fkeb061fe7b62cd586 FOREIGN KEY (usersessionid) REFERENCES usersession(usersessionid);


--
-- Name: folder_workspaceid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY folder
    ADD CONSTRAINT folder_workspaceid_fkey FOREIGN KEY (workspaceid) REFERENCES workspace(workspaceid);


--
-- Name: form_formtypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY form
    ADD CONSTRAINT form_formtypeid_fkey FOREIGN KEY (formtypeid) REFERENCES formtype(formtypeid);


--
-- Name: form_incidentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY form
    ADD CONSTRAINT form_incidentid_fkey FOREIGN KEY (incidentid) REFERENCES incident(incidentid);


--
-- Name: form_usersessionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY form
    ADD CONSTRAINT form_usersessionid_fkey FOREIGN KEY (usersessionid) REFERENCES usersession(usersessionid);


--
-- Name: image_incident_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY image
    ADD CONSTRAINT image_incident_id_fkey FOREIGN KEY (incident_id) REFERENCES incident(incidentid) ON DELETE CASCADE;


--
-- Name: image_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY image
    ADD CONSTRAINT image_location_id_fkey FOREIGN KEY (location_id) REFERENCES location(id) ON DELETE CASCADE;


--
-- Name: incident_incidenttype_incidentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY incident_incidenttype
    ADD CONSTRAINT incident_incidenttype_incidentid_fkey FOREIGN KEY (incidentid) REFERENCES incident(incidentid);


--
-- Name: incident_incidenttype_incidenttypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY incident_incidenttype
    ADD CONSTRAINT incident_incidenttype_incidenttypeid_fkey FOREIGN KEY (incidenttypeid) REFERENCES incidenttype(incidenttypeid);


--
-- Name: incident_usersessionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY incident
    ADD CONSTRAINT incident_usersessionid_fkey FOREIGN KEY (usersessionid) REFERENCES usersession(usersessionid);


--
-- Name: incident_workspaceid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY incident
    ADD CONSTRAINT incident_workspaceid_fkey FOREIGN KEY (workspaceid) REFERENCES workspace(workspaceid);


--
-- Name: layerstyle_datalayerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY datalayerstyle
    ADD CONSTRAINT layerstyle_datalayerid_fkey FOREIGN KEY (datalayerid) REFERENCES datalayer(datalayerid);


--
-- Name: location_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_user_id_fkey FOREIGN KEY (user_id) REFERENCES user_info(user_id) ON DELETE CASCADE;


--
-- Name: log_logid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY log_workspace
    ADD CONSTRAINT log_logid_fkey FOREIGN KEY (logid) REFERENCES log(logid);


--
-- Name: log_logtypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY log
    ADD CONSTRAINT log_logtypeid_fkey FOREIGN KEY (logtypeid) REFERENCES logtype(logtypeid);


--
-- Name: log_usersessionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY log
    ADD CONSTRAINT log_usersessionid_fkey FOREIGN KEY (usersessionid) REFERENCES usersession(usersessionid);


--
-- Name: log_workspaceid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY log_workspace
    ADD CONSTRAINT log_workspaceid_fkey FOREIGN KEY (workspaceid) REFERENCES workspace(workspaceid);


--
-- Name: operational_period_incident_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY operational_period
    ADD CONSTRAINT operational_period_incident_id_fkey FOREIGN KEY (incident_id) REFERENCES incident(incidentid) ON DELETE CASCADE;


--
-- Name: org_orgtype_orgid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY org_orgtype
    ADD CONSTRAINT org_orgtype_orgid_fkey FOREIGN KEY (orgid) REFERENCES org(orgid);


--
-- Name: org_orgtype_orgtypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY org_orgtype
    ADD CONSTRAINT org_orgtype_orgtypeid_fkey FOREIGN KEY (orgtypeid) REFERENCES orgtype(orgtypeid);


--
-- Name: orgformtype_fkey_formtypeid; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY orgformtype
    ADD CONSTRAINT orgformtype_fkey_formtypeid FOREIGN KEY (formtypeid) REFERENCES formtype(formtypeid);


--
-- Name: orgformtype_fkey_orgid; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY orgformtype
    ADD CONSTRAINT orgformtype_fkey_orgid FOREIGN KEY (orgid) REFERENCES org(orgid);


--
-- Name: parent_incidentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY incident
    ADD CONSTRAINT parent_incidentid_fkey FOREIGN KEY (parentincidentid) REFERENCES incident(incidentid);


--
-- Name: resource_assign_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY resource_assign
    ADD CONSTRAINT resource_assign_user_id_fkey FOREIGN KEY (user_id) REFERENCES user_info(user_id) ON DELETE CASCADE;


--
-- Name: resource_assignment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY resource_assign
    ADD CONSTRAINT resource_assignment_fkey FOREIGN KEY (unit_id, operational_period_id) REFERENCES assignment(unit_id, operational_period_id);


--
-- Name: system_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY system_workspace
    ADD CONSTRAINT system_id_fkey FOREIGN KEY (systemid) REFERENCES nicssystem(systemid);


--
-- Name: systemrole_userorgid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY systemrole_workspace
    ADD CONSTRAINT systemrole_userorgid_fkey FOREIGN KEY (systemroleid) REFERENCES systemrole(systemroleid);


--
-- Name: systemrole_workspaceid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY systemrole_workspace
    ADD CONSTRAINT systemrole_workspaceid_fkey FOREIGN KEY (workspaceid) REFERENCES workspace(workspaceid);


--
-- Name: task_assign_form_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY task_assign
    ADD CONSTRAINT task_assign_form_id_fkey FOREIGN KEY (form_id) REFERENCES form(formid) ON DELETE CASCADE;


--
-- Name: task_assignment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY task_assign
    ADD CONSTRAINT task_assignment_fkey FOREIGN KEY (unit_id, operational_period_id) REFERENCES assignment(unit_id, operational_period_id);


--
-- Name: unit_collabroom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY unit
    ADD CONSTRAINT unit_collabroom_id_fkey FOREIGN KEY (collabroom_id) REFERENCES collabroom(collabroomid) ON DELETE CASCADE;


--
-- Name: unit_incident_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY unit
    ADD CONSTRAINT unit_incident_id_fkey FOREIGN KEY (incident_id) REFERENCES incident(incidentid) ON DELETE CASCADE;


--
-- Name: user_info_ics_position_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY user_info_ics_position
    ADD CONSTRAINT user_info_ics_position_code_fkey FOREIGN KEY (code) REFERENCES ics_position(code) ON DELETE CASCADE;




--
-- Name: user_info_ics_position_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY user_info_ics_position
    ADD CONSTRAINT user_info_ics_position_user_id_fkey FOREIGN KEY (user_id) REFERENCES user_info(user_id) ON DELETE CASCADE;


--
-- Name: user_info_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY user_info
    ADD CONSTRAINT user_info_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(userid);


--
-- Name: userorg_orgid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY userorg
    ADD CONSTRAINT userorg_orgid_fkey FOREIGN KEY (orgid) REFERENCES org(orgid);


--
-- Name: userorg_systemroleid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY userorg
    ADD CONSTRAINT userorg_systemroleid_fkey FOREIGN KEY (systemroleid) REFERENCES systemrole(systemroleid);


--
-- Name: userorg_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY userorg
    ADD CONSTRAINT userorg_userid_fkey FOREIGN KEY (userid) REFERENCES "user"(userid);


--
-- Name: userorg_userorgid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY userorg_workspace
    ADD CONSTRAINT userorg_userorgid_fkey FOREIGN KEY (userorgid) REFERENCES userorg(userorgid);


--
-- Name: userorg_workspaceid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY userorg_workspace
    ADD CONSTRAINT userorg_workspaceid_fkey FOREIGN KEY (workspaceid) REFERENCES workspace(workspaceid);


--
-- Name: usersession_userorgid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY usersession
    ADD CONSTRAINT usersession_userorgid_fkey FOREIGN KEY (userorgid) REFERENCES userorg(userorgid);


--
-- Name: workspace_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nics
--

ALTER TABLE ONLY system_workspace
    ADD CONSTRAINT workspace_id_fkey FOREIGN KEY (workspaceid) REFERENCES workspace(workspaceid);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

