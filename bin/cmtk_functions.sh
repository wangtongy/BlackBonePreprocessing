#!/bin/sh

##
##  Copyright 2007-2011, 2014 SRI International
##
##  This file is part of the Computational Morphometry Toolkit.
##
##  http://www.nitrc.org/projects/cmtk/
##
##  The Computational Morphometry Toolkit is free software: you can
##  redistribute it and/or modify it under the terms of the GNU General Public
##  License as published by the Free Software Foundation, either version 3 of
##  the License, or (at your option) any later version.
##
##  The Computational Morphometry Toolkit is distributed in the hope that it
##  will be useful, but WITHOUT ANY WARRANTY; without even the implied
##  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
##
##  You should have received a copy of the GNU General Public License along
##  with the Computational Morphometry Toolkit.  If not, see
##  <http://www.gnu.org/licenses/>.
##
##  $Revision: 5378 $
##
##  $LastChangedDate: 2015-01-17 11:31:55 -0800 (Sat, 17 Jan 2015) $
##
##  $LastChangedBy: torstenrohlfing $
##

export CMTK_BINARY_DIR=${CMTK_BINARY_DIR:-/data/anlab/Chunwei/software/cmtk/build/bin}

# Check whether we have "lockfile" tool available and include proper script with locking functions
if which lockfile > /dev/null; then
    . ${CMTK_BINARY_DIR}/cmtk_locking_procmail.sh
else
    . ${CMTK_BINARY_DIR}/cmtk_locking.sh
fi

# For convenience and readability
cmtk()
{
  ${CMTK_BINARY_DIR}/$*
}

#
# Given a .hdr file name, compress corresponding .img file.
#
gzip_hdr_img()
{
    for i in $*; do
	local img=`echo ${i} | sed 's/\.hdr/\.img/g'`
	gzip -9f ${img}
    done
}

#
# Echo a command line, then execute it.
#
echo_and_exec()
{
    echo $*
    $*
}

#
# Find file in list of paths
#
find_file()
{
    local file=$1
    shift

    for d in $*; do
	test -e ${d}/${file} && echo ${d}/${file} && return
    done

    echo "COULD NOT FIND: $file" > /dev/stderr
}
