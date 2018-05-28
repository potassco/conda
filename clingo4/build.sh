#!/bin/bash

CXXFLAGS=$(echo "${CXXFLAGS}" | sed "s/c++17/c++11/g")

mkdir build
cat <<EOF > build/release.py
CXX = '${CXX}'
CXXFLAGS = '${CXXFLAGS}'
CPPPATH = ['${CONDA_PREFIX}/include']
CPPDEFINES = {'NDEBUG': 1}
LIBS = []
LIBPATH = []
LINKFLAGS = '${LDFLAGS} -L${CONDA_PREFIX}/lib'
RPATH = []
AR = '${AR}'
ARFLAGS = ['rc']
RANLIB = 'ranlib'
BISON = 'bison'
RE2C = 're2c'
PYTHON_CONFIG = 'python${PY_VER}-config'
PKG_CONFIG = 'pkg-config'
WITH_PYTHON = 'auto'
WITH_LUA = False
WITH_TBB = 'tbb'
WITH_CPPUNIT = False
EOF

patch -p0 <<EOF
--- libgringo/src/term.cc.orig  2018-02-23 16:42:45.641207919 +0100
+++ libgringo/src/term.cc       2018-02-23 16:40:04.011651101 +0100
@@ -21,6 +21,7 @@
 #include "gringo/term.hh"
 #include "gringo/logger.hh"
 #include "gringo/graph.hh"
+#include <cmath>
 
 namespace Gringo {
 
EOF

scons -j${CPU_COUNT} --build-dir=release gringo clingo reify pyclingo

mkdir -p "${PREFIX}/bin/"
mkdir -p "${SP_DIR}/"

cp -a build/release/{gringo,clingo,reify} "${PREFIX}/bin/"
cp -a build/release/python/gringo.so "${SP_DIR}/"
