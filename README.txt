====
	Copyright (c) 2008-${year}, Massachusetts Institute of Technology (MIT)
	All rights reserved.

	Redistribution and use in source and binary forms, with or without 
	modification, are permitted provided that the following conditions are met:

	1. Redistributions of source code must retain the above copyright notice, this 
	list of conditions and the following disclaimer.

	2. Redistributions in binary form must reproduce the above copyright notice, 
	this list of conditions and the following disclaimer in the documentation 
	and/or other materials provided with the distribution.

	3. Neither the name of the copyright holder nor the names of its contributors 
	may be used to endorse or promote products derived from this software without 
	specific prior written permission.

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
	DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE 
	FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
	DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
	SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
	CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
	OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
	OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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

