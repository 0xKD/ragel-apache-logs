CC = gcc
CFLAGS = -Wall -Wextra -O3
all: parser
clean:
	$(RM) parser.c parser
parser.c: parser.rl logformat.rl
	ragel -C parser.rl
parser: parser.c
	gcc parser.c -o parser
