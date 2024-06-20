echo on

mkdir re2c_build

cmake -G "Ninja" -S . -B re2c_build ^
    -DCMAKE_CXX_COMPILER="%CXX%" ^
    -DCMAKE_C_COMPILER="%CC%" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"

cmake --build re2c_build
cmake --build re2c_build --target install
