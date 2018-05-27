#!/bin/bash

./configure --prefix=${PREFIX} CXX="${CXX}" CC="${CC}"
make -j${CPU_COUNT}
make install

