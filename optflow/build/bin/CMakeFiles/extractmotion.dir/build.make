# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Produce verbose output by default.
VERBOSE = 1

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/nordlikg/fmi/test_interpolation16-bit/optflow

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/nordlikg/fmi/test_interpolation16-bit/optflow/build

# Include any dependencies generated for this target.
include bin/CMakeFiles/extractmotion.dir/depend.make

# Include the progress variables for this target.
include bin/CMakeFiles/extractmotion.dir/progress.make

# Include the compile flags for this target's objects.
include bin/CMakeFiles/extractmotion.dir/flags.make

bin/CMakeFiles/extractmotion.dir/extractmotion.cpp.o: bin/CMakeFiles/extractmotion.dir/flags.make
bin/CMakeFiles/extractmotion.dir/extractmotion.cpp.o: ../bin/extractmotion.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/nordlikg/fmi/test_interpolation16-bit/optflow/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object bin/CMakeFiles/extractmotion.dir/extractmotion.cpp.o"
	cd /home/nordlikg/fmi/test_interpolation16-bit/optflow/build/bin && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/extractmotion.dir/extractmotion.cpp.o -c /home/nordlikg/fmi/test_interpolation16-bit/optflow/bin/extractmotion.cpp

bin/CMakeFiles/extractmotion.dir/extractmotion.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/extractmotion.dir/extractmotion.cpp.i"
	cd /home/nordlikg/fmi/test_interpolation16-bit/optflow/build/bin && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/nordlikg/fmi/test_interpolation16-bit/optflow/bin/extractmotion.cpp > CMakeFiles/extractmotion.dir/extractmotion.cpp.i

bin/CMakeFiles/extractmotion.dir/extractmotion.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/extractmotion.dir/extractmotion.cpp.s"
	cd /home/nordlikg/fmi/test_interpolation16-bit/optflow/build/bin && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/nordlikg/fmi/test_interpolation16-bit/optflow/bin/extractmotion.cpp -o CMakeFiles/extractmotion.dir/extractmotion.cpp.s

bin/CMakeFiles/extractmotion.dir/extractmotion.cpp.o.requires:
.PHONY : bin/CMakeFiles/extractmotion.dir/extractmotion.cpp.o.requires

bin/CMakeFiles/extractmotion.dir/extractmotion.cpp.o.provides: bin/CMakeFiles/extractmotion.dir/extractmotion.cpp.o.requires
	$(MAKE) -f bin/CMakeFiles/extractmotion.dir/build.make bin/CMakeFiles/extractmotion.dir/extractmotion.cpp.o.provides.build
.PHONY : bin/CMakeFiles/extractmotion.dir/extractmotion.cpp.o.provides

bin/CMakeFiles/extractmotion.dir/extractmotion.cpp.o.provides.build: bin/CMakeFiles/extractmotion.dir/extractmotion.cpp.o

# Object files for target extractmotion
extractmotion_OBJECTS = \
"CMakeFiles/extractmotion.dir/extractmotion.cpp.o"

# External object files for target extractmotion
extractmotion_EXTERNAL_OBJECTS =

bin/extractmotion: bin/CMakeFiles/extractmotion.dir/extractmotion.cpp.o
bin/extractmotion: lib/liboptflow.so
bin/extractmotion: bin/CMakeFiles/extractmotion.dir/build.make
bin/extractmotion: bin/CMakeFiles/extractmotion.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable extractmotion"
	cd /home/nordlikg/fmi/test_interpolation16-bit/optflow/build/bin && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/extractmotion.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
bin/CMakeFiles/extractmotion.dir/build: bin/extractmotion
.PHONY : bin/CMakeFiles/extractmotion.dir/build

bin/CMakeFiles/extractmotion.dir/requires: bin/CMakeFiles/extractmotion.dir/extractmotion.cpp.o.requires
.PHONY : bin/CMakeFiles/extractmotion.dir/requires

bin/CMakeFiles/extractmotion.dir/clean:
	cd /home/nordlikg/fmi/test_interpolation16-bit/optflow/build/bin && $(CMAKE_COMMAND) -P CMakeFiles/extractmotion.dir/cmake_clean.cmake
.PHONY : bin/CMakeFiles/extractmotion.dir/clean

bin/CMakeFiles/extractmotion.dir/depend:
	cd /home/nordlikg/fmi/test_interpolation16-bit/optflow/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/nordlikg/fmi/test_interpolation16-bit/optflow /home/nordlikg/fmi/test_interpolation16-bit/optflow/bin /home/nordlikg/fmi/test_interpolation16-bit/optflow/build /home/nordlikg/fmi/test_interpolation16-bit/optflow/build/bin /home/nordlikg/fmi/test_interpolation16-bit/optflow/build/bin/CMakeFiles/extractmotion.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : bin/CMakeFiles/extractmotion.dir/depend

