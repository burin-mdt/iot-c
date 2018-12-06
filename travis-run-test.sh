#!/bin/bash
#*******************************************************************************
#  Copyright (c) 2018 IBM Corp.
#
#  All rights reserved. This program and the accompanying materials
#  are made available under the terms of the Eclipse Public License v1.0
#  and Eclipse Distribution License v1.0 which accompany this distribution.
#
#  The Eclipse Public License is available at
#     http://www.eclipse.org/legal/epl-v10.html
#  and the Eclipse Distribution License is available at
#    http://www.eclipse.org/org/documents/edl-v10.php.
#
#  Contributors:
#     Ranjan Dasgupta - initial drop of WIoTP iot-c client
#
#*******************************************************************************/
#
# This script setups up test environment and execute unit and functional tests
#

set -e

cd iot-c

CURDIR=`pwd`
export CURDIR

OSTYPE=`uname -s`
export OSTYPE

echo "Running tests on ${OSTYPE}"

#
# Test Setup - create device types and devices in the platform test organization
#
echo "Setup tests: create device types and devices in WIoTP service"
chmod +x ./test/test.sh
./test/test.sh setup
echo
echo

#
# Run tests
#
echo "Run test suites"
make run_tests
echo

#
# Test Cleanup - delete device types and devices in the platform test organization
#
echo "Setup tests: delete device types and devices in WIoTP service"
./test/test.sh cleanup
echo
echo



