#!/bin/bash

mkdir build
cd build

if [ -z "${PYTHON}" ]; then
    PYTHON="$(which python)"
fi

cmake .. \
    -DCMAKE_CXX_COMPILER="${CXX}" \
    -DCMAKE_C_COMPILER="${CC}" \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_INSTALL_LIBDIR="lib" \
    -DBOOST_ROOT="${CONDA_PREFIX}" \
    -DCMAKE_BUILD_TYPE=Release

make -j${CPU_COUNT}
make install

