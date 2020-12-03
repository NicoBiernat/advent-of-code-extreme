
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

- [x] Day 1: Pascal (FreePascal)
- [x] Day 2: Elixir
- [x] Day 3: C# (.NET)
- [ ] Day 4:
- [ ] Day 5:
- [ ] Day 6: C with CUDA / OpenCL (might be a bad idea when the challenge is based around string processing...)
- [ ] Day 7:
- [ ] Day 8:
- [ ] Day 9:
- [ ] Day 10
- [ ] Day 11:
- [ ] Day 12:
- [ ] Day 13:
- [ ] Day 14:
- [ ] Day 15:
- [ ] Day 16:
- [ ] Day 17:
- [ ] Day 18:
- [ ] Day 19:
- [ ] Day 20:
- [ ] Day 21:
- [ ] Day 22:
- [ ] Day 23:
- [ ] Day 24: Java with Apache Flink
- [ ] Day 25: