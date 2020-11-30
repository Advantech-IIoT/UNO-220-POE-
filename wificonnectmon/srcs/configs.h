#ifndef __wificonnectmon_configs_h__ 
#define __wificonnectmon_configs_h__ 

typedef struct wificonnectmon_configs_s {
  char name[32]; 
  int bg; 
  int debug; 
  int gpio; 
  const char *pidfile; 
} wificonnectmon_configs; 

#endif /* __wificonnectmon_configs_h__ */

