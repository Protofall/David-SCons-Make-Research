# Flags example

This example aims to demonstraight how the two different build systems would build the same program, but with different compiler flags. In this case a flag that is passed to the compiler when making main.o that will effect how the final executable will behave.

### Make usage

`make` will pass in no extra flags resulting in the final executable outputting the default "Other" message

`make version1` will pass in `MYFLAG=1` to the compiler making it output "Hi"

`make version2` will pass in `MYFLAG=2` to the compiler making it output "Bye"

`make clean` will clean up all files made by this program

### SCons usage

`scons` or `scons version=[Number that isn't 1 or 2]` is the equivalent of `make`. If the version number is not 1 or 2 the version defaults to zero which is the same as no argument passed in.

`scons version=1` will pass in `MYFLAG=1` and output "Hi"

`scons version=2` will pass in `MYFLAG=2` and output "Bye"

`scons -c` will clean up the files
