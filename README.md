# OpenWrt-package-using-CMake
This repository is demonstrating how to employ CMake for building packages for an OpenWrt system.  

Obtain an OpenWrt [build environment](https://openwrt.org/docs/guide-developer/toolchain/install-buildsystem) and update and install your 'feeds' packages.
Configure the cross-compilation toolchain for your target device by navigating to the OpenWrt build system root directory and executing the command:
```linux
make menuconfig
```
From the menu, choose the suitable 'Target System', 'Subtarget' and 'Target Profile'. Exit saving changes. Build the target-independent tools and the cross-compilation toolchain:
'''linux
make toolchain/install
'''
Add the target independent tools to your PATH variable:
'''linux
export PATH=/home/openwrt/staging_dir/host/bin:$PATH
'''
Your build environment is now ready to create packages.

Preparing project 

Create a directory <package name> in this case "example1" this is the top level directory where our package manifest file "Makefile.mk" will reside, it must atleast contain the package description, where to obtain the source code, final package install instructions. I have not yet looked into additional configuration.

One level down from the top directory is where our source code and CMake files will reside.

Your project structure can vary but to maintain my personal standard which should keep things organized follow this structure:

Top-directory (package name)
├── Project-files (main CMake)
│   ├── CMakeLists.txt
│   └── Source-code
│       ├── Libraries
│       │   ├── xyz.c
│       │   └── xyz.h
│       └── main.c
└── Makefile(package manifest file)

Create a CMakeList.txt file, this is the entry point of our project this file contains the instructions on how to build our project and will be generating the make files that actually execute the process. Some specific scripts that we need to specify are as follows:

'''cmake
project(name)
'''
For the sake of remaining consistent with the build prepare and install instructions in the package manifest file keep the name of your cmake project identical to the name of your package. 

'''cmake
file(GLOB SRC_FILES "src/*.c" / "src/libs/*.c") 
'''
Obtain the paths of all source files needed to be included in the final executable and store in a created variable (SRC_FILES).
Using this method we forgo the use of multiple commands for linking libraries and employing CMakeLists.txt for each subdirectory where our project dependencies are situated.

'''cmake
add_executable(${PROJECT_NAME} ${SRC_FILES})

INSTALL(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION /usr/bin/)
'''
The project name is stored in the cmake variable PROJECT_NAME, create an executable from our source files and install it in the build directory(path is consistent with the above file structure).

At this point we have created our package repository and it can be placed in the the build environment's package directory which is present in the root directory of our build environment. When we execute the make command to build and create the package any package repositories present in the build environment's package folder are automatically updated. However it would be advisable to create a seperate directory for your custom package repositories, but we need to create package feed for this directory and include it into the OpenWRT build system as follows:

Create a directory "mypackages" where you will place your OpenWRT package repositories. 
Navigate to the source directory of OpenWRT buildsystem and create a file "feeds.conf".
edit the file with:
'''
src-link mypackages /<global path>/mypackages
'''
Now we update the package index of the OpenWRT build system with our new feed this will include all package repositories, present in the directory "mypackages", in the configuration menu:
'''
./scripts/feeds update mypackages
./scripts/feeds install -a -p mypackages
'''

Building the package

In the root directory of the buildsystem run the command:
'''
make menuconfig
'''
Navigate to the package and highlight it to include it into the firmware configuration, exit the menu saving the configuration.

To build the package:
'''
make package/example1/compile
'''
If everything went successfully, we are presented with a brand new package named example_1.0-0_<arch>.ipk in bin/packages/<arch>/mypackages folder.

