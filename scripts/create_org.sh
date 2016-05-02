#!/bin/bash
#
# Copyright (c) 2008-2016, Massachusetts Institute of Technology (MIT)
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
# list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its contributors
# may be used to endorse or promote products derived from this software without
# specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

set -e;

if [ "$1" == "" ]
then
  echo "You must specify a database name to prepend to the data databases."
  exit 1
fi

if [ "$2" == "" ]
then
  echo "You must specify a name for the organization"
  exit 1
fi

if [ "$3" == "" ]
then
  echo "You must specify a state for the organization"
  exit 1
fi

if [ "$4" == "" ]
then
  echo "You must specify a county. If it doesn't apply, use ''."
  exit 1
fi

if [ "$5" == "" ]
then
  echo "You must specify a prefix for the organization"
  exit 1
fi

if [ "$6" == "" ]
then
  echo "You must specify an orgtypeid, this can be found in the orgtype table"
  exit 1
fi

# create the org
# name, county, state, prefix, orgtypeid
psql -c "INSERT INTO org VALUES ((select nextval('org_seq')), '$2', '$3', '$4', NULL, '$5', NULL, 38.8950000000000031, -77.0366700000000009, NULL, 'USA', now())" $1
psql -c "INSERT INTO org_orgtype VALUES ((select nextval('hibernate_sequence')), (select last_value from org_seq), $6)" $1


