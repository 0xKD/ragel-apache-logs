Nginx-log-parser
=================

Experimental fork of [ragel-apache-logs](https://github.com/emcien/ragel-apache-logs) for nginx access logs. Work in progress.

Branch details:

**master**: Parse `argv[1]` as the log line

Usage: 
```bash
./parser '<log_line_here>'
```

**logstructs**: Parse multiple lines from stdin

Usage: 
```bash
cat access.log | ./parser
```

