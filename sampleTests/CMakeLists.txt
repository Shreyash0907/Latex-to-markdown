cmake_minimum_required(VERSION 3.1)
project(unitTests VERSION 1.0 LANGUAGES C CXX)

find_package(GTest REQUIRED)
find_package (Threads)
find_package(FLEX)
find_package(BISON)

set(TESTFILE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
set(CODE_DIR "${TESTFILE_DIR}/..")
set(OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")

set(LEXER_OUT "${OUTPUT_DIRECTORY}/lexer.cpp")
set(PARSER_OUT "${OUTPUT_DIRECTORY}/parser.cpp")

flex_target(LEXER "${CODE_DIR}/lexer.l" "${LEXER_OUT}" DEFINES_FILE "${OUTPUT_DIRECTORY}/lexer.hpp" )
bison_target(PARSER "${CODE_DIR}/parser.y" "${PARSER_OUT}" DEFINES_FILE "${OUTPUT_DIRECTORY}/parser.hpp")
add_flex_bison_dependency(LEXER PARSER)
set(NODE_CPP "${CODE_DIR}/Node.cpp")
add_executable(unitTests 
            "${PARSER_OUT}" 
            "${LEXER_OUT}"
            "${NODE_CPP}"
            "${TESTFILE_DIR}/test.cpp")

target_include_directories(unitTests PRIVATE "${OUTPUT_DIRECTORY}" "${CODE_DIR}" "${CODE_DIR}/build")

target_link_libraries(unitTests ${GTEST_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT}) 

enable_testing()
add_test(add unitTests)