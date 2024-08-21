cmake_minimum_required(VERSION 3.10)

# Project name and version
project(latex2markdown VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(OUTPUT_DIR "${CMAKE_CURRENT_BINARY_DIR}")

find_package(FLEX REQUIRED)
find_package(BISON REQUIRED)

FLEX_TARGET(Lexer "${CMAKE_SOURCE_DIR}/lexer.l" "${OUTPUT_DIR}/lex.yy.cpp" DEFINES_FILE "${OUTPUT_DIR}/lex.yy.hpp")
BISON_TARGET(Parser "${CMAKE_SOURCE_DIR}/parser.y" "${OUTPUT_DIR}/parser.tab.cpp" DEFINES_FILE "${OUTPUT_DIR}/parser.tab.hpp")

set(NODE_CPP "${CMAKE_SOURCE_DIR}/Node.cpp")
ADD_FLEX_BISON_DEPENDENCY(Lexer Parser)

include_directories(${OUTPUT_DIR})
include_directories(${CMAKE_SOURCE_DIR})

add_executable(latex2markdown
    ${BISON_Parser_OUTPUTS}
    ${FLEX_Lexer_OUTPUTS}
    ${NODE_CPP}
    ${CMAKE_SOURCE_DIR}/main.cpp) 

target_include_directories(latex2markdown PRIVATE "${OUTPUT_DIR}")

