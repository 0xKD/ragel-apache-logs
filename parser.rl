#include <stdio.h>
#include <string.h>

#define MAX_LINE_LENGTH 4096

char inbuffer[MAX_LINE_LENGTH], outbuffer[MAX_LINE_LENGTH];

%%{
  
  machine parser;

  # Include the machine definition
  include clf "clf.rl";

  # Instantiate the machine
  main := line;

  # Write the state transitions for the instantiated machine
  write data;

}%%

// Ragel-exposed variables
int cs;
char *p, *pe, *ts;

// Marks the start of the last-seen token
static inline void mark() { ts = p; }

// Defines what to do when we finish consuming a token
// In this case, we format it as JSON and write it to a buffer containing the
//   partially-constructed object corresponding to the current line
static inline void emit(char *type) {
  *p = '\0';
  char fmtbuffer[MAX_LINE_LENGTH];
  sprintf(fmtbuffer, "\"%s\":\"%s\",", type, ts);
  strcat(outbuffer, fmtbuffer);
}

int main() {
  int lines = 0;

  fputc('[', stdout); // We're printing out a list objects. Here's the start.
  while(fgets(inbuffer, MAX_LINE_LENGTH, stdin) != NULL) {
    // Start writing the JSON object to the buffer 
    // Include a leading comma if we need to separate it from its predecessor
    if (lines) { 
      strcpy(outbuffer, ",\n{");
    } else {
      strcpy(outbuffer, "{");
    }

    // Set Ragel to read the contents of the buffer
    p  = inbuffer;
    pe = inbuffer + strlen(inbuffer);
    ts = p;

    // Setup and run the state machine
    // This will consume input from p to pe and call mark() and emit() as
    //   specified in our machine definition
    %% write init;  
    %% write exec;

    // Finalize the object, chomping off the last comma
    int len = strnlen(outbuffer, MAX_LINE_LENGTH);
    outbuffer[len - 1] = '\0';
    fprintf(stdout, "%s}", outbuffer);
    lines ++;
  }
  fprintf(stdout, "]\n");
  return 0;
}