#include <stdio.h>
#include <string.h>

#define MAX_LINE_LENGTH 4096

%%{
	machine parser;
	include logformat "logformat.rl";
	main := line;
	write data;
}%%

int cs;
char *p, *pe, *ts;

static void test() {
	*p = '\0';
	printf("%s\n", ts);
}

static void saveptr() {
	ts = p;
}

int main(int argc, char **argv) {
	if (argc > 1) {
		p = argv[1];
		pe = p + strlen(p);
		ts = p;

		%%{
			write init;
			write exec;
		}%%
	}
	printf("result: %i\n", cs >= parser_first_final);
	return 0;
}

