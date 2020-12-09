# CPU Temperature Monitor for UNO-220
---

## Sample Code

### C

On System: 

```bash=
$ ls /usr/Advantech/cputempmon/cputempmon.c
cputempmon.c
```

### Python

```bash=
$ ls /usr/Advantech/cputempmon/python
configs  cputempmon.py  fork  led  syslog  temperature
```

Latest code on Github: 

- [cputempmon.c](https://github.com/advantechralph/uno-220/blob/samples/cputempmon/srcs/cputempmon.c)
- [cputempmon.py](https://github.com/advantechralph/uno-220/blob/samples/cputempmon/srcs/python)

---

## cputempmon

Usage: 

```shell=
$ cd /usr/Advantech/cputempmon
$ sudo ./cputempmon --help
                                                            
  Usage:                                                   
     cputempmon [OPTION] [ARGV]                                    
                                                           
  OPTION:                                                  
    -h, --help                                             
      Show this usage.                                     
    -b, --background                                       
      Background mode.                                     
    -d, --debug                                            
      Debug mode.                                          
    -k, --stop                                             
      Stop background service.                             
    -g, --gpio                                             
      Set GPIO indicator.                                  
      Default: GPIO12                                      
    -t, --temp                                             
      Set warning temperature.                             
      Default: 50.0°C                                      
    -T, --time                                             
      Set pooling time.                                    
      Default: 5 sec                                       
    -p, --pidfile                                          
      Set pid file                                         
      Default: /var/run/cputempmon.pid    
```

Start monitor

```bash=
$ sudo ./cputempmon -b 
cputempmon configurations:
  temp                : 50.000
  time                : 5
  pidfile             : /var/run/cputempmon.pid
  bg                  : 1
  gpio                : 12
```

Stop monitor

```bash=
$ sudo ./cputempmon -k
```

Default LED indicator is GPIO 12. You can check indicator or check log to see if the temperature is over settings. 

Check log

```bash=
$ journalctl -t cputempmon
-- Logs begin at Wed 2020-12-09 09:27:35 GMT, end at Wed 2020-12-09 09:54:55 GMT. --
Dec 09 09:54:15 raspberrypi cputempmon[1125]: cputempmon: enter background mode...
Dec 09 09:54:15 raspberrypi cputempmon[1136]: measure_temp(), 318: temp: 50.63 over level 50.00
Dec 09 09:54:20 raspberrypi cputempmon[1136]: measure_temp(), 318: temp: 50.63 over level 50.00
Dec 09 09:54:25 raspberrypi cputempmon[1136]: measure_temp(), 318: temp: 50.63 over level 50.00
Dec 09 09:54:30 raspberrypi cputempmon[1136]: measure_temp(), 318: temp: 50.63 over level 50.00
Dec 09 09:54:35 raspberrypi cputempmon[1136]: measure_temp(), 318: temp: 51.61 over level 50.00
Dec 09 09:54:40 raspberrypi cputempmon[1136]: measure_temp(), 318: temp: 50.63 over level 50.00
Dec 09 09:54:45 raspberrypi cputempmon[1136]: measure_temp(), 318: temp: 51.12 over level 50.00
Dec 09 09:54:50 raspberrypi cputempmon[1136]: measure_temp(), 318: temp: 50.63 over level 50.00
Dec 09 09:54:55 raspberrypi cputempmon[1136]: measure_temp(), 318: temp: 51.12 over level 50.00
$ date
Wed Dec  9 09:55:09 GMT 2020

```

---

## cputempmon.py

Usage: 

```bash=
$ sudo /usr/Advantech/cputempmon/python/cputempmon.py --help

                                                           
  Usage:                                                   
     /usr/Advantech/cputempmon/python/cputempmon.py [OPTION]
                                                           
  OPTION:                                                  
    -h, --help                                             
      Show this usage.                                     
    -b, --background                                       
      Background mode.                                     
    -d, --debug [0|1]                                      
      Debug mode.                                          
    -k, --stop                                             
      Stop background service.                             
    -g, --gpio [number]                                    
      Set GPIO indicator.                                  
      Default: GPIO12                                      
    -t, --temp [number]                                    
      Set warning temperature.                             
      Default: 50.0 C                                      
    -T, --time [number]                                    
      Set pooling time.                                    
      Default: 5 sec                                       
    -p, --pidfile [path]                                   
      Set pid file                                         
      Default: /var/run/cputempmon-py.pid                                          
                                                           


```

Start monitor

```bash=
$ cd /usr/Advantech/cputempmon/python
$ sudo ./cputempmon.py -b 
./python/cputempmon.py: 
  info : <bound method configs.info of <configs.__class__.configs instance at 0xb67e1b48>>
  usage : <bound method configs.usage of <configs.__class__.configs instance at 0xb67e1b48>>
  bg : 0
  name : ./python/cputempmon.py
  temp : 50.0
  time : 5
  debug : 0
  gpio : 12
  stop : <bound method fork.stop of <fork.__class__.fork instance at 0xb67e1ad0>>
  pidfile : /var/run/cputempmon-py.pid
GPIO 12 is controlled by sysfs
Enter background mode...

```

Check log

```bash=
$ journalctl -t cputempmon.py | tail
Dec 09 10:16:34 raspberrypi cputempmon.py[1898]: temp: 50.634, over 50.000
Dec 09 10:16:39 raspberrypi cputempmon.py[1898]: temp: 50.634, over 50.000
Dec 09 10:16:44 raspberrypi cputempmon.py[1898]: temp: 51.121, over 50.000
Dec 09 10:17:04 raspberrypi cputempmon.py[2050]: temp: 51.121, over 50.000
Dec 09 10:17:09 raspberrypi cputempmon.py[2050]: temp: 50.147, over 50.000
Dec 09 10:17:14 raspberrypi cputempmon.py[2050]: temp: 51.121, over 50.000
Dec 09 10:17:19 raspberrypi cputempmon.py[2050]: temp: 50.634, over 50.000
Dec 09 10:17:24 raspberrypi cputempmon.py[2050]: temp: 50.147, over 50.000
Dec 09 10:17:34 raspberrypi cputempmon.py[2050]: temp: 50.634, over 50.000
Dec 09 10:17:39 raspberrypi cputempmon.py[2050]: temp: 51.121, over 50.000

```


---
###### tags: `uno220` `raspberrypi`