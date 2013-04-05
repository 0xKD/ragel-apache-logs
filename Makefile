CC     = gcc
CFLAGS = -Wall -Wextra -O3

all: parser debugger
viz: clf.png
clean: 
	$(RM) parser.o parser.c debugger clf.png

parser: parser.o

parser.c: parser.rl clf.rl
	ragel -G2 parser.rl -o parser.c

debugger: debugger.rl clf.rl
	ragel -R -T1 debugger.rl -o debugger

clf.png: parser.rl clf.rl
	ragel -Vp parser.rl | dot -Tpng -o clf.png