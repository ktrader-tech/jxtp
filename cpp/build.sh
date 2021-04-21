rm -rf build
cmake CMakeLists.txt -B build
cmake --build build --config Release
lib_ext=".so"
lib_ext=$([[ $(uname) = "Darwin" ]] && echo ".dylib")
cp "build/lib/libjxtp${lib_ext}" ../lib
