#!/bin/bash

mkdir build
cd build

cmake .. \
    -DCMAKE_CXX_COMPILER="${CXX}" \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_INSTALL_LIBDIR="lib" \
    -DCLINGCON_BUILD_SHARED=On \
    -DCLINGCON_MANAGE_RPATH=Off \
    -DCMAKE_BUILD_TYPE=Release

make -j${CPU_COUNT}
make install

