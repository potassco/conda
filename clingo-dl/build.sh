#!/bin/bash

mkdir build
cd build

cmake .. \
    -DCMAKE_CXX_COMPILER="${CXX}" \
    -DCMAKE_C_COMPILER="${CC}" \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_INSTALL_LIBDIR="lib" \
    -DCLINGODL_BUILD_WITH_SYSTEM_CLINGO=On \
    -DCMAKE_BUILD_TYPE=Release

make -j${CPU_COUNT}
make install

