
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <syslog.h>

int main(void){
  openlog("syslog_test", LOG_PID, LOG_LOCAL0);
  // setlogmask(LOG_UPTO(LOG_INFO));
  // info level will be ignore...
  setlogmask(~LOG_MASK(LOG_INFO));
  // syslog(LOG_EMERG, "test logemerg\n");
  syslog(LOG_ALERT, "test logalert\n");
  syslog(LOG_CRIT, "test logcrit\n");
  syslog(LOG_ERR, "test logerr\n");
  syslog(LOG_WARNING, "test logwarning\n");
  syslog(LOG_NOTICE, "test lognotice\n");
  syslog(LOG_INFO, "test loginfo\n");
  syslog(LOG_DEBUG, "test logdebug\n");
  closelog();
  return 0;
} 
