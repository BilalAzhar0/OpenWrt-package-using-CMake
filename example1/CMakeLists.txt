cmake_minimum_required(VERSION 2.6)
project(Example1)

file(GLOB SRC_FILES "src/*.c" / "src/libs/*.c")

add_executable(${PROJECT_NAME} ${SRC_FILES})

INSTALL(TARGETS ${SRC_FILES} RUNTIME DESTINATION /usr/bin/)

