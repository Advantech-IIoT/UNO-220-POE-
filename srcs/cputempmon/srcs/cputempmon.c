
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <string.h>

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

#define CPUTEMPMONGPIO 12

void led_control(int on){
  char cmdBuf[128] = {0}; 
  sprintf(cmdBuf, "echo %d > /sys/class/gpio/gpio%d/value", on, CPUTEMPMONGPIO);
  system(cmdBuf);
}

void led_init(void){
  char cmdBuf[128] = {0}; 
  FILE *fp = NULL; 
  if(access("/sys/kernel/debug/gpio", R_OK) != 0){
    printf("No permission to access sysfs!!\n");
    exit(-1);
  }
  sprintf(cmdBuf, "cat /sys/kernel/debug/gpio | grep \"gpio-%d \"", CPUTEMPMONGPIO);
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
        printf("gpio-%d controlled by sysfs\n", CPUTEMPMONGPIO);
      }else{
        printf("gpio-%d controlled by other driver...\n", CPUTEMPMONGPIO);
	exit(-1);
      }
    }else{
      printf("gpio-%d not controlled\n", CPUTEMPMONGPIO);
      sprintf(cmdBuf, "echo %d > /sys/class/gpio/export", CPUTEMPMONGPIO);
      system(cmdBuf);
      sprintf(cmdBuf, "echo out > /sys/class/gpio/gpio%d/direction", CPUTEMPMONGPIO);
      system(cmdBuf);
      sprintf(cmdBuf, "echo 1 > /sys/class/gpio/gpio%d/active_low", CPUTEMPMONGPIO);
      system(cmdBuf);
    }
    // led init indicator
    int i = 0; 
    for(i = 0; i < 10; i++){
      led_control(0);
      usleep(200000);
      led_control(1);
      usleep(200000);
    }
  }
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
      printf("%s, %d: temp: %.2f over level %.2f\n", __FUNCTION__, __LINE__, temp, level);
      led_control(1);
    }else{
      led_control(0);
    }
    fclose(fp);
  }
}

int main(void){
  pid_t pid = 0; 
  led_init();
  if((pid = fork()) == 0){
    while(1){
      // measure_temp_test2();
      measure_temp(50.1);
      sleep(5);
    }
  }else{
    // printf("Start 'CPU Temperature Monitor' in background. \n");
    while(1) sleep(10);
  }
  return 0;
}

