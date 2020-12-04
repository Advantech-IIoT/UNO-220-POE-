
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <string.h>
#include <syslog.h>
#include <libgen.h>
#include <getopt.h>
#include <stdarg.h>

typedef struct cputempmon_configs_s {
  char name[32]; 
  int bg; 
  int debug; 
  int gpio; 
  float temp; 
  const char *pidfile; 
} cputempmon_configs; 

static cputempmon_configs configs; 

#define CPUTEMPMONGPIO 12

const char default_pidfile[] = "/var/run/cputempmon.pid"; 

void show_message(const char *fmt, ...){
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
      if(configs.debug == 1) printf("%s", p);
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
    -t, --temp                                             \n\
      Set warning temperature.                             \n\
      Default: 50.0°C                                      \n\
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
  {"temp",        1, 0, 't'},
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
  printf("  %-20s: %.3f\n", "temp", configs.temp);
  printf("  %-20s: %s\n", "pidfile", configs.pidfile);
  printf("  %-20s: %d\n", "bg", configs.bg);
  printf("  %-20s: %d\n", "gpio", configs.gpio);
}

void initconfigs(char *name){
  memset(&configs, 0, sizeof(cputempmon_configs));
  strncpy(configs.name, name, sizeof(configs.name)-1); 
  configs.temp = 50.0; 
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
      case 't':
	sscanf(optarg, "%f", &configs.temp);
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

void measure_temp_test(void){
  FILE *fp = popen("vcgencmd measure_temp", "r");
  if(fp){
    char buf[32] = {0};
    int len = 0;
    float temp = 0.0;
    len = fread(buf, 1, 31, fp);
    buf[len]='\0';
    printf("%s, %d: len: %d, buf: %s\n", __FUNCTION__, __LINE__, len, buf);
    sscanf(buf, "temp=%f'C", &temp);
    printf("%s, %d: temp: %.1f\n", __FUNCTION__, __LINE__, temp);
    pclose(fp);
  }
}

void measure_temp_test2(void){
  FILE *fp = fopen("/sys/class/thermal/thermal_zone0/temp", "r");
  if(fp){
    char buf[32] = {0};
    int len = 0;
    float temp = 0.0;
    len = fread(buf, 1, 31, fp);
    buf[len]='\0';
    printf("%s, %d: len: %d, buf: %s\n", __FUNCTION__, __LINE__, len, buf);
    temp = (atoi(buf) / 1000.0); 
    printf("%s, %d: temp: %.1f\n", __FUNCTION__, __LINE__, temp);
    fclose(fp);
  }
}

void led_control(int on){
  char cmdBuf[128] = {0}; 
  sprintf(cmdBuf, "echo %d > /sys/class/gpio/gpio%d/value", on, configs.gpio);
  system(cmdBuf);
}

void led_init(void){
  char cmdBuf[128] = {0}; 
  FILE *fp = NULL; 
  if(access("/sys/kernel/debug/gpio", R_OK) != 0){
    printf("No permission to access sysfs!!\n");
    exit(-1);
  }
  sprintf(cmdBuf, "cat /sys/kernel/debug/gpio | grep \"gpio-%d \"", configs.gpio);
  fp = popen(cmdBuf, "r");
  if(fp){
    int ret = 0; 
    int buf[64] = {0}; 
    int len = 0; 
    len = fread(buf, 1, 63, fp);
    if(len > 0) buf[len] = '\0'; 
    ret = pclose(fp);
    if(WEXITSTATUS(ret) == 0){
      if(strstr((const char*)buf, "sysfs") != NULL){
        printf("gpio-%d controlled by sysfs\n", configs.gpio);
      }else{
        printf("gpio-%d controlled by other driver...\n", configs.gpio);
	exit(-1);
      }
    }else{
      printf("gpio-%d not controlled\n", configs.gpio);
      sprintf(cmdBuf, "echo %d > /sys/class/gpio/export", configs.gpio);
      system(cmdBuf);
      sprintf(cmdBuf, "echo out > /sys/class/gpio/gpio%d/direction", configs.gpio);
      system(cmdBuf);
      sprintf(cmdBuf, "echo 1 > /sys/class/gpio/gpio%d/active_low", configs.gpio);
      system(cmdBuf);
    }
    // led init indicator
    int i = 0; 
    for(i = 0; i < 5; i++){
      led_control(0);
      usleep(100000);
      led_control(1);
      usleep(100000);
    }
  }
  led_control(0);
}

void measure_temp(float level){
  FILE *fp = fopen("/sys/class/thermal/thermal_zone0/temp", "r");
  if(fp){
    char buf[32] = {0};
    int len = 0;
    float temp = 0.0;
    len = fread(buf, 1, 31, fp);
    buf[len]='\0';
    temp = (atoi(buf) / 1000.0); 
    if(temp > level) {
//      printf("%s, %d: temp: %.2f over level %.2f\n", __FUNCTION__, __LINE__, temp, level);
      show_message("%s(), %d: temp: %.2f over level %.2f\n", __FUNCTION__, __LINE__, temp, level);
      led_control(1);
    }else{
      led_control(0);
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
  led_init();
  openlog("cputempmon", LOG_PID, LOG_LOCAL0);
  atexit(atexit_func); 
  if((pid = fork()) == 0){
    appendpid2file(); 
    while(1){
      // measure_temp_test2();
      measure_temp(configs.temp);
      sleep(5);
    }
  }else{
    if(configs.bg == 1){
      show_message("%s: enter background mode...", configs.name);
    }else{
      appendpid2file(); 
      while(1){
        sleep(10);
      }
    }
  }
  return 0;
}

