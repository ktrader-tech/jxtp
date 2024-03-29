cmake_minimum_required(VERSION 3.16)

if(MSVC)
    add_compile_options(
            $<$<CONFIG:>:/MT> #---------|
            $<$<CONFIG:Debug>:/MTd> #---|-- Statically link the runtime libraries
            $<$<CONFIG:Release>:/MT> #--|
    )
endif()

set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)

if (WIN32)
    set(include_dir ../include/windows)
elseif(UNIX)
    add_compile_options(-fpermissive)
    set(include_dir ../include/linux)
elseif(APPLE)
    add_compile_options(-fpermissive)
    set(include_dir ../include/darwin)
else()
    set(include_dir ../include)
endif ()
include_directories(${include_dir})

link_directories(../../lib)

add_library(
        jxtp SHARED
        jxtp.h jxtp.cpp
)

target_link_libraries(jxtp xtptraderapi xtpquoteapi)