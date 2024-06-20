mkdir re2c_build

cmake -G "Visual Studio 15 2017" -S. -Bre2c_build ^
    -DCMAKE_CXX_COMPILER="%CXX%" ^
    -DCMAKE_C_COMPILER="%CC%" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^

cmake --build re2c_build --config release
cmake --build re2c_build --config release --target install
