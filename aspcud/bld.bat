mkdir build

cmake -G "%CMAKE_GENERATOR%" -H. -Bbuild ^
    -DCMAKE_CXX_COMPILER="%CXX%" ^
    -DCMAKE_C_COMPILER="%CC%" ^
    -DCMAKE_INSTALL_PREFIX="%PREFIX%" ^
    -DASPCUD_CUDF2LP_PATH="<module_path>\\cudf2lp.exe" ^
    -DASPCUD_GRINGO_PATH="<module_path>\\gringo.exe" ^
    -DASPCUD_CLASP_PATH="<module_path>\\clasp.exe" ^
    -DASPCUD_ENCODING_PATH="<module_path>\\share\\aspcud\\misc2012.lp" ^
    -DCMAKE_INSTALL_BINDIR="."

cmake --build build --config Release
cmake --build build --config Release --target install
