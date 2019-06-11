#makefile

all: main.o
	gcc "main.o" -o "main"

.PHONY: version1
version1: dirs a/main.o
	gcc -o "main" "a/main.o"

.PHONY: version2
version2: dirs b/main.o
	gcc -o "main" "b/main.o"

a/main.o: main.c
	gcc -DMYFLAG=1 -c $^ -o $@

b/main.o: main.c
	gcc -DMYFLAG=2 -c $^ -o $@

.PHONY: dirs
dirs:
	mkdir -p a b

.PHONY: clean
clean:
	rm -f main.o main
	rm -rf a b
