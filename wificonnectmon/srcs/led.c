
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <string.h>
#include <syslog.h>
#include <libgen.h>
#include <getopt.h>
#include <stdarg.h>

void led_control(int gpio, int on){
  char cmdBuf[128] = {0}; 
  sprintf(cmdBuf, "echo %d > /sys/class/gpio/gpio%d/value", on, gpio);
  system(cmdBuf);
}

void led_init(int gpio){
  char cmdBuf[128] = {0}; 
  FILE *fp = NULL; 
  if(access("/sys/kernel/debug/gpio", R_OK) != 0){
    printf("No permission to access sysfs!!\n");
    exit(-1);
  }
  sprintf(cmdBuf, "cat /sys/kernel/debug/gpio | grep \"gpio-%d \"", gpio);
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
        printf("gpio-%d controlled by sysfs\n", gpio);
      }else{
        printf("gpio-%d controlled by other driver...\n", gpio);
	exit(-1);
      }
    }else{
      printf("gpio-%d not controlled\n", gpio);
      sprintf(cmdBuf, "echo %d > /sys/class/gpio/export", gpio);
      system(cmdBuf);
      sprintf(cmdBuf, "echo out > /sys/class/gpio/gpio%d/direction", gpio);
      system(cmdBuf);
      sprintf(cmdBuf, "echo 1 > /sys/class/gpio/gpio%d/active_low", gpio);
      system(cmdBuf);
    }
    // led init indicator
    int i = 0; 
    for(i = 0; i < 5; i++){
      led_control(gpio, 0);
      usleep(100000);
      led_control(gpio, 1);
      usleep(100000);
    }
  }
  led_control(gpio, 0);
}

