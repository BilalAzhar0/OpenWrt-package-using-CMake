cmake_minimum_required(VERSION 3.5)
project(example1)

file(GLOB SRC_FILES "src/*.c" / "src/libs/*.c")

add_executable(${PROJECT_NAME} ${SRC_FILES})

INSTALL(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION /usr/bin/)

