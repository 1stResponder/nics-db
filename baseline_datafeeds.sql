SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

-- Mobile Device Tracking geospatial layer
create table mdt (
	uid SERIAL PRIMARY KEY, 
	id VARCHAR, 
	name VARCHAR, 
	description VARCHAR, 
	timestamp TIMESTAMP WITH TIME ZONE, 
	speed DOUBLE PRECISION, 
	course DOUBLE PRECISION, 
	extendeddata VARCHAR, 
	styler VARCHAR
);

select AddGeometryColumn('mdt', 'geom', 3857, 'POINT', 2);

-- Age filtered view for mdt table
create or replace view mdt_view as 
	select * from (select *, extract('epoch' from now()-mdt.timestamp) as age from mdt) as a where age < 14400;