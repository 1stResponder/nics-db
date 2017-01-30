#!/bin/bash
#
# Copyright (c) 2008-2015, Massachusetts Institute of Technology (MIT)
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


if [ "$1" == "" ]
then
  echo "You must specify a username name to create and populate."
  exit 1
fi

if [ "$2" == "" ]
then
  echo "You must specify an organization's id."
  exit 1
fi

if [ "$3" == "" ]
then
  echo "You must specify a workspace id"
  exit 1
fi

# create the database
psql -c "INSERT INTO \"user\" VALUES ((select nextval('user_seq')), '$1', 'NQg1uTRTu6Q7vvZA/j+OXDafTZw=', 'Default', 'User', now(), true, now(), '\x1cf09e162a9b3bbe20e7c0aaffec9e4d','t',now())" nics
psql -c "INSERT INTO userorg VALUES ((select nextval('user_org_seq')), (select last_value from user_seq), '$2', 0, now(), NULL, '', '', '')" nics
psql -c "INSERT INTO userorg_workspace VALUES ($3, (select last_value from user_org_seq), (select nextval('hibernate_sequence')), 't')" nics



