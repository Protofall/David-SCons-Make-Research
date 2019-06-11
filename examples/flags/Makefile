#makefile

flags=
.PHONY: version1 version2 clean

all: main.o
	gcc "main.o" -o "main"

version1: flags += "-DMYFLAG=1"
version1: all

version2: flags += "-DMYFLAG=2"
version2: all

%.o: %.c
	gcc $(flags) -c $^ -o $@

clean:
	rm -f main.o main
