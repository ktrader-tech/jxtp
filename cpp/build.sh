rm -rf build
cmake CMakeLists.txt -B build
cmake --build build --config Release
lib_ext=$([[ "$(uname -s)" = "Darwin"  ]] && echo ".dylib" || echo ".so")
cp "build/lib/libjxtp${lib_ext}" ../lib
