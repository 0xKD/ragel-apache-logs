Nginx-log-parser
=================

Experimental fork of [ragel-apache-logs](https://github.com/emcien/ragel-apache-logs) for nginx access logs. Work in progress.

Master branch: Parse argv[1] as the log line
Usage: `./parser '<log_line_here>'`

Logstructs: Parse multiple lines from stdin
Usage: `cat access.log | ./parser`

