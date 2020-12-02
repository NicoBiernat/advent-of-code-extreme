
# advent-of-code-extreme

## The rules are simple:

Complete https://adventofcode.com/2020 with 24 different programming languages.

##### You can find a list of programming languages ordered by my experience with them [here](https://github.com/NicoBiernat/advent-of-code-extreme/blob/main/programming-languages.md).

I am using Docker and Makefiles to make the build process easier and to prevent 24 compilers and language runtimes being installed on my system (some of which I will probably not use that often).
So docker is required!

Usage for day x:
```shell
cd dayX
make
```
This will do the following:
- setup the compiler/runtime in a docker container
- compile the application (if necessary)
- run the application (in a docker container)
- cleanup everything but the code afterwards  

If you want to "make" different targets, please take a look at the corresponding Makefile.

# List of used programming languages

- Day 1: Pascal (FreePascal)
