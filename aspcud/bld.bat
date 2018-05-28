mkdir build

cmake -G "%CMAKE_GENERATOR%" -H. -Bbuild ^
    -DCMAKE_CXX_COMPILER="%CXX%" ^
    -DCMAKE_C_COMPILER="%CC%" ^
    -DCMAKE_INSTALL_PREFIX="%PREFIX%" ^
    -DCMAKE_INSTALL_BINDIR="."

cmake --build build --config Release
cmake --build build --config Release --target install
