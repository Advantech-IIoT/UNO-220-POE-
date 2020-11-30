
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <string.h>
#include <syslog.h>
#include <libgen.h>
#include <getopt.h>
#include <stdarg.h>

void show_message(int debug, const char *fmt, ...){
  int n;
  int size = 100;
  char *p, *np;
  va_list ap;

  if ((p = malloc(size)) == NULL) goto err; 

  while (1) {
    va_start(ap, fmt);
    n = vsnprintf(p, size, fmt, ap);
    va_end(ap);

    if (n < 0) goto err; 

    if (n < size){
      if(debug == 1) printf("%s", p);
      syslog(LOG_WARNING, "%s", p);
      free(p);
      return; 
    }

    size = n + 1; 
    if ((np = realloc (p, size)) == NULL) {
      goto err; 
    } else {
      p = np;
    }
  }
err: 
  printf("%s(), %d: error!!\n", __FUNCTION__, __LINE__);
  syslog(LOG_WARNING, "%s(), %d: error...\n", __FUNCTION__, __LINE__);
  if(p) free(p);
}

void SYSTEM(const char *fmt, ...){
  int n;
  int size = 100;
  char *p, *np;
  va_list ap;

  if ((p = malloc(size)) == NULL) goto err; 

  while (1) {
    va_start(ap, fmt);
    n = vsnprintf(p, size, fmt, ap);
    va_end(ap);

    if (n < 0) goto err; 

    if (n < size){
      system(p);
      free(p);
      return; 
    }

    size = n + 1; 
    if ((np = realloc (p, size)) == NULL) {
      goto err; 
    } else {
      p = np;
    }
  }
err: 
  printf("%s(), %d: error!!\n", __FUNCTION__, __LINE__);
  if(p) free(p);
}

