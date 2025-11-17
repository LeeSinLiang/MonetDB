# CMake generated Testfile for 
# Source directory: /home/user/MonetDB/ctest
# Build directory: /home/user/MonetDB/build-fuzzing/ctest
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(TestEcho "/usr/bin/cmake" "-E" "echo" "'MonetDB" "Testing'")
set_tests_properties(TestEcho PROPERTIES  _BACKTRACE_TRIPLES "/home/user/MonetDB/ctest/CMakeLists.txt;14;add_test;/home/user/MonetDB/ctest/CMakeLists.txt;0;")
subdirs("monetdb5")
subdirs("tools")
