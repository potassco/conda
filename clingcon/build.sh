#!/bin/bash

mkdir build
cd build

cmake .. \
    -DCMAKE_CXX_COMPILER="${CXX}" \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_INSTALL_LIBDIR="lib" \
    -DCLINGCON_BUILD_SHARED=On \
    -DCLINGCON_MANAGE_RPATH=Off \
    -DPYCLINGCON_ENABLE="require" \
    -DPYCLINGCON_USER_INSTALL=Off \
    -DPYCLINGCON_USE_INSTALL_PREFIX=On \
    -DCMAKE_BUILD_TYPE=Release

make -j${CPU_COUNT}
make install

