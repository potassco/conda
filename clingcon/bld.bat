mkdir build

cmake -G "%CMAKE_GENERATOR%" -H. -Bbuild ^
    -DCMAKE_CXX_COMPILER="%CXX%" ^
    -DCMAKE_INSTALL_PREFIX="%PREFIX%" ^
    -DCLINGCON_BUILD_WITH_SYSTEM_CLINGO=On ^
    -DCMAKE_INSTALL_BINDIR="."

cmake --build build --config Release
cmake --build build --config Release --target install
