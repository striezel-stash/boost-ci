#! /bin/bash
#
# Copyright 2022 Alexander Grund
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE_1_0.txt or copy at
#      http://www.boost.org/LICENSE_1_0.txt)
#
# Bash script to perform a CMake build of Boost
#
# Requires the following env vars:
# - BOOST_ROOT & SELF (setup step)
# - BCM_GENERATOR
# - BCM_BUILD_TYPE
# - BCM_SHARED_LIBS
# - BCM_ARGS
# - BCM_TARGET

set -e

. "$(dirname "${BASH_SOURCE[0]}")"/set_num_jobs.sh

cd "$BOOST_ROOT"
mkdir __build_cmake_test__ && cd __build_cmake_test__

echo "Configuring..."
cmake -G "$BCM_GENERATOR" -DCMAKE_BUILD_TYPE=$BCM_BUILD_TYPE -DBUILD_SHARED_LIBS=$BCM_SHARED_LIBS -DBOOST_INCLUDE_LIBRARIES=$SELF -DBoost_VERBOSE=ON "${BCM_ARGS[@]}" ..

echo "Building..."
cmake --build . --target $BCM_TARGET --config $BCM_BUILD_TYPE -j$B2_JOBS

if [[ "$TARGET" == "tests" ]]; then
    echo "Testing..."
    ctest --output-on-failure --build-config $BCM_BUILD_TYPE
fi
