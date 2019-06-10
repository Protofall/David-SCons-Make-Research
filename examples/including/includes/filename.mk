#included file "filename.mk"

VERSION := "1.6.2"

%.o: %.c
	gcc -c -o $@ $<