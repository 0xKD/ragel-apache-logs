#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LINE_LENGTH 4096

char inbuffer[MAX_LINE_LENGTH];

%%{
	machine parser;
	include logformat "logformat.rl";
	main := line;
	write data;
}%%

struct Log {
	char *ip;
	char *date;
	char *request;
	char *status;
	char *size;
	char *referer;
	char *useragent;
};

int cs;
char *p, *pe, *ts;

static void nullify() { *p = '\0'; }
static void saveptr() {	ts = p; }

static void inline save_ip(struct Log *log) { log->ip = ts;}
static void inline save_request(struct Log *log) { log->request = ts; }
static void inline save_status(struct Log *log) { log->status = ts; }
static void inline save_date(struct Log *log) { log->date = ts; }
static void inline save_size(struct Log *log) { log->size = ts; }
static void inline save_referer(struct Log *log) { log->referer = ts; }
static void inline save_useragent(struct Log *log) { log->useragent = ts; }

static void print_log(struct Log *log) {
	printf("IP: %s | ", log->ip);
	printf("Date: %s | ", log->date);
	printf("Request: %s | ", log->request);
	printf("Status: %s | ", log->status);
	printf("User-agent: %s\n", log->useragent);
}

int main(int argc, char **argv) {
	struct Log *myLog = malloc(sizeof(struct Log));
	while (fgets(inbuffer, MAX_LINE_LENGTH, stdin) != NULL) {
		p = inbuffer;
		pe = inbuffer + strlen(inbuffer);
		ts = p;

		%%{
			write init;
			write exec;
		}%%
		// printf("result: %i\n", cs >= parser_first_final);
		// print_log(myLog);
	}
	return 0;
}

