cmake_minimum_required(VERSION 3.21)
project(FlexBisonTemplate)

include(scripts/flex-bison.cmake)
fetch_flex_bison()

add_flex_target(run_flex ${CMAKE_SOURCE_DIR}/calculator.l OUTPUT ${CMAKE_SOURCE_DIR}/gen/scanner.h)
add_bison_target(run_bison ${CMAKE_SOURCE_DIR}/calculator.y OUTPUT ${CMAKE_SOURCE_DIR}/gen/parser.h)

add_executable(tst parser.cpp)
add_dependencies(tst run_flex run_bison)