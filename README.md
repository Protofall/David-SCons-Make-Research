# SCons-Make-Research
Software used to get data from SCons and Make projects

For my research project I need to compare a set of projects using SCons against a set of projects using Make. This repository contains text files with links to my test data repositories, two bash scripts to clone and search the repositories for relevant data and an output csv files with the extracted data.

### Usage:

`./download.sh` will read the repository txt files and download all repositories (About 21.5GB as of the 5th of June 2019)

`./collect_data.sh` will explore these repositories for Makefile and SConstruct files and extract data from them. They will then output one csv file per language/build tool in the "results" directory

### Other stuff:

The `examples` directory contains a few examples showing how some things would be done with Makefile and SConstruct files and highlighs the differences, strengths and flaws
