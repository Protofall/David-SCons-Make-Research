#makefile

flags=
.PHONY: flag1 flag2 clean

all: main.o
	gcc "main.o" -o "main"

flag1: flags += "-DMYFLAG=1"
flag1: all

flag2: flags += "-DMYFLAG=2"
flag2: all

%.o: %.c
	gcc $(flags) -c $^ -o $@

clean:
	rm -f main.o main
