====
    (c) Copyright, 2008-2014 Massachusetts Institute of Technology.

        This material may be reproduced by or for the
        U.S. Government pursuant to the copyright license
        under the clause at DFARS 252.227-7013 (June, 1995).
====

NICS Database Setup
====================

There are 3 main scripts to note:

- baseline.sql: Specifies the baseline schema. This is as of NICS 6.0.
- baseline_data.sql: Specifies the baseline data for the NICS database.
- create_db.sh: A script file that can be executed to create the database as of a certain version. This script should be updated for each release to include any incremental change SQL script file that is required for the corresponding NICS version. The incremental change scripts should go into the 'changes' directory.

Executing the 'create_db.sh' requires that a database name parameter is passed (e.g. "./create_db.sh integration"). The script will create the database with the specified name, create the baseline schema for that database, insert the baseline data for that database, and will execute any of the SQL change scripts (as long as they have been added to the 'create_db.sh' script file).

NICS System Setup
====================

There are 3 scripts that will help to set up a basic system

- /scripts/create_system.sh:
	(1) Name of the system - this usually corresponds to the application's hostname. For instance, if the site is hosted at "nics.ll.mit.edu", this system name would be "nics"
	(2) A description of the system - optional
	(3) A unique system id - recommend starting with 1
	(4) A workspace name - this will appear as a button on the main page, for example "Incident"
	(5) A unique workspace id - recommend starting with 1

- /scripts/create_org.sh:
	(1) Name of the organization
	(2) County - optional
	(3) State
	(4) Prefix
	(5) The orgtype id - this will allow users to register with this organization. The ids can be found in the orgtype table

- /scripts/create_default_user.sh: The password is set to TestPassword1!
	(1) Username
	(2) Organization Id (query org table)
	(3) Workspace Id (query workspace table)

