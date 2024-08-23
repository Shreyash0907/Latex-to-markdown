cmake_minimum_required(VERSION 3.1)
project(converterUnitTest VERSION 1.0 LANGUAGES C CXX)

find_package(GTest REQUIRED)
find_package (Threads)
find_package(FLEX)
find_package(BISON)

set(TEST_SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
set(CODE_SRC_DIR "${TEST_SRC_DIR}/..")
set(OUTPUT_DIR "${CMAKE_CURRENT_BINARY_DIR}")

set(TEX_FILES
    ${TEST_SRC_DIR}/italic.tex
    ${CMAKE_SOURCE_DIR}/path/to/your/file2.tex
    ${CMAKE_SOURCE_DIR}/path/to/your/file3.tex
)

set(LEXER_OUT "${OUTPUT_DIR}/lexer.cpp")
set(PARSER_OUT "${OUTPUT_DIR}/parser.cpp")

flex_target(LEXER "${CODE_SRC_DIR}/lexer.l" "${LEXER_OUT}" DEFINES_FILE "${OUTPUT_DIR}/lexer.hpp" )
bison_target(PARSER "${CODE_SRC_DIR}/parser.y" "${PARSER_OUT}" DEFINES_FILE "${OUTPUT_DIR}/parser.hpp")
add_flex_bison_dependency(LEXER PARSER)
set(NODE_CPP "${CODE_SRC_DIR}/Node.cpp")
add_executable(converterUnitTest 
            "${PARSER_OUT}" 
            "${LEXER_OUT}"
            "${NODE_CPP}"
            "${TEST_SRC_DIR}/test.cpp")

target_include_directories(converterUnitTest PRIVATE "${OUTPUT_DIR}" "${CODE_SRC_DIR}" "${CODE_SRC_DIR}/build")

target_link_libraries(converterUnitTest ${GTEST_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT}) 

enable_testing()
add_test(add converterUnitTest)