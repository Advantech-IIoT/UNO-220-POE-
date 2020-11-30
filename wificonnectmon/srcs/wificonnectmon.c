
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <string.h>
#include <syslog.h>
#include <libgen.h>
#include <getopt.h>
#include <stdarg.h>
#include "configs.h"
#include "utils.h"
#include "led.h"

static wificonnectmon_configs configs; 

#define CPUTEMPMONGPIO 12

const char default_pidfile[] = "/var/run/wificonnectmon.pid"; 

const char usage_fmt[]=" \
                                                           \n\
  Usage:                                                   \n\
     %s [OPTION] [ARGV]                                    \n\
                                                           \n\
  OPTION:                                                  \n\
    -h, --help                                             \n\
      Show this usage.                                     \n\
    -b, --background                                       \n\
      Background mode.                                     \n\
    -d, --debug                                            \n\
      Debug mode.                                          \n\
    -k, --stop                                             \n\
      Stop background service.                             \n\
    -g, --gpio                                             \n\
      Set GPIO indicator.                                  \n\
      Default: GPIO%d                                      \n\
    -p, --pidfile                                          \n\
      Set pid file                                         \n\
      Default: %s                                          \n\
                                                           \n\
"; 

void usage_func(void){
  printf(usage_fmt, configs.name, configs.gpio, configs.pidfile);
  exit(EXIT_SUCCESS); 
}

static struct option long_options[] = {
  {"pid",         1, 0, 'p'},
  {"gpio",        1, 0, 'g'},
  {"background",  0, 0, 'b'},
  {"debug",       0, 0, 'd'},
  {"stop",        0, 0, 'k'},
  {"help",        0, 0, 'h'},
  {0,             0, 0,  0 }
};

void showconfigs(void){
  printf("%s configurations:\n", configs.name);
  printf("  %-20s: %s\n", "pidfile", configs.pidfile);
  printf("  %-20s: %d\n", "bg", configs.bg);
  printf("  %-20s: %d\n", "gpio", configs.gpio);
}

void initconfigs(char *name){
  memset(&configs, 0, sizeof(wificonnectmon_configs));
  strncpy(configs.name, name, sizeof(configs.name)-1); 
  configs.bg = 0; 
  configs.pidfile = default_pidfile; 
  configs.debug = 0; 
  configs.gpio = CPUTEMPMONGPIO; 
}

void removepidfile(void){
  remove(configs.pidfile); 
}

void appendpid2file(void){
  FILE *fp = fopen(configs.pidfile, "a+"); 
  if(fp != NULL){
    fprintf(fp, "%d\n", getpid()); 
    fclose(fp);
  }
}

int getconfigs(int argc, char **argv){
  int c;
  int stop = 0; 
  initconfigs(basename(argv[0]));
  while (1) {
    int option_index = 0;
    c = getopt_long(argc, argv, "?hbkt:p:g:", long_options, &option_index);
    if (c == -1)
      break;
    switch (c) {
      case 'b':
	configs.bg = 1; 
        break;
      case 'd':
	configs.debug = 1; 
        break;
      case 'k':
	stop = 1; 
        break;
      case 'g':
	sscanf(optarg, "%d", &configs.gpio);
        break;
      case 'p':
	configs.pidfile = optarg; 
        break;
      case '?':
      case 'h':
	usage_func();
        break;
      default:
	usage_func();
    }
  }
  if(stop == 1){
    SYSTEM("kill -9 $(cat %s)", configs.pidfile);
    removepidfile();
    exit(EXIT_SUCCESS);
  }
  showconfigs(); 
  removepidfile();
  return 0; 
}

void wifi_operstate(void){
  FILE *fp = fopen("/sys/class/net/wlan0/operstate", "r");
  if(fp){
    char buf[32] = {0};
    int len = 0;
    len = fread(buf, 1, 31, fp);
    buf[len]='\0';
    if(strncmp(buf, "up", 2) == 0) {
      led_control(configs.gpio, 1);
    }else{
      led_control(configs.gpio, 0);
    }
    fclose(fp);
  }
}

void atexit_func(void){
  closelog();
}

int main(int argc, char *argv[]){
  pid_t pid = 0; 
  getconfigs(argc, argv); 
  led_init(configs.gpio);
  openlog("wificonnectmon", LOG_PID, LOG_LOCAL0);
  atexit(atexit_func); 
  if((pid = fork()) == 0){
    appendpid2file(); 
    while(1){
      wifi_operstate();
      sleep(3);
    }
  }else{
    if(configs.bg == 1){
      show_message(configs.debug, "%s: enter background mode...", configs.name);
    }else{
      appendpid2file(); 
      while(1){
        sleep(10);
      }
    }
  }
  return 0;
}

