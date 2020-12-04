#!/usr/bin/python -B

import os, re, time, sys, getopt, signal, syslog, atexit

import configs, fork, led, temperature

def childfunc():
  temp = temperature.get()
  if temp > c['temp'] :
    if c['debug'] == 1 :
      print("temp: %.3f, over %.3f"%(temp, c['temp']))
    syslog.syslog(syslog.LOG_WARNING, "temp: %.3f, over %.3f"%(temp, c['temp']))
    led.control(1, c['gpio'])
  else :
    led.control(0, c['gpio'])
  time.sleep(c['time'])

def parentfunc():
  time.sleep(10)

def atexit_func() :
#  print("pid %d: exit!!"%(os.getpid()))
  syslog.closelog()

if __name__ == '__main__' :
  global c, f 
  atexit.register(atexit_func)
  f = fork.fork(pidfile="/var/run/cputempmon-py.pid")
  c = configs.configs(name=sys.argv[0], pidfile="/var/run/cputempmon-py.pid", stop=f.stop)
  c.getopt(sys.argv[1:])
  f['parent'] = parentfunc 
  f['child'] = childfunc 
  syslog.openlog("%s"%(os.path.basename(sys.argv[0])), syslog.LOG_LOCAL0 | syslog.LOG_PID)
  led.init(c['gpio'])
  f.run(c['bg'])


