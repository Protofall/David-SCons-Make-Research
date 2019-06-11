# Includes example

This example shows how a user would "include" another file for extra build rules and variables in Make and SCons. Note that SCons does have a "site_dir" which be default looks in the same directory as the SConstruct file, but this method would be able to load another file from anywhere on your computer.

### Make usage

`make` will include the "filename.mk" file and use its object compiler and version variable in the main program

`make clean` will clean up all files made by this program

### SCons usage

`scons` loads the "filename.py" file with an object builder and a version variable and uses both of them

`scons -c` will clean up the files
