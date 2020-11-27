#!/usr/bin/env python

import os, re, time, sys, getopt, signal, syslog, atexit

CPUTEMPMONGPIO=12
MONTEMP=51.0
BG=0

def check_gpio_sysfs() :
  ret = os.access("/sys/kernel/debug/gpio", os.R_OK)
  if ret == False: 
    print("no permission for gpio sysfs...")
    exit(1)
#  else: 
#    print("access gpio sysfs: ready")

def led_control(on, led) : 
  os.system("echo %d > /sys/class/gpio/gpio%d/value"%(on, led));

def led_init(led) :
  check_gpio_sysfs()
  fp = os.popen("cat /sys/kernel/debug/gpio | grep \"gpio-%d\""%(led))
  s = fp.read(64)
  ret = fp.close()
  if ret == None : 
    l = re.split("  *", s)
    nl = filter(lambda s: s != '', l)
    if len(filter(lambda _s: re.search("sysfs", _s), nl)) > 0 :
      print("GPIO %d is controlled by sysfs"%(led))
    else :
      print("GPIO %d is not controlled by sysfs. \nPlease check if GPIO %d is controlled by other driver"%(led, led))
      exit(1)
  else : 
    os.system("echo %d > /sys/class/gpio/export"%(led));
  os.system("echo out > /sys/class/gpio/gpio%d/direction"%(led));
  os.system("echo 1 > /sys/class/gpio/gpio%d/active_low"%(led));
  print("gpio %d blinking testing..."%(led))
  for i in range(5) : 
    led_control(0, CPUTEMPMONGPIO)
    time.sleep(0.2)
    led_control(1, CPUTEMPMONGPIO)
    time.sleep(0.2)

def measure_temp(montemp):
  fd = os.open("/sys/class/thermal/thermal_zone0/temp", os.O_RDONLY)
  s = os.read(fd, 64)
  temp = (int(s)/1000.0)
  if temp > montemp :
#    print("temp: %.3f, over %.3f"%(temp, montemp))
    syslog.syslog(syslog.LOG_WARNING, "temp: %.3f, over %.3f"%(temp, montemp))
    led_control(1, CPUTEMPMONGPIO)
  else :
    led_control(0, CPUTEMPMONGPIO)
  os.close(fd)

def loop(bg=0):
  syslog.syslog(syslog.LOG_INFO, "loop start!!")
  if os.fork() == 0 :
    while True == True : 
#      syslog.syslog(syslog.LOG_INFO, "child loop...")
      measure_temp(MONTEMP)
      time.sleep(5)
  else :
    if bg == 1 :
      return
    else :
      while True == True : 
#        syslog.syslog(syslog.LOG_INFO, "parent loop...")
        time.sleep(10)

def main() : 
  global CPUTEMPMONGPIO, BG
  led_init(CPUTEMPMONGPIO)
  loop(BG)


def usage():
  usage_str="""
Usage: 

    %s [OPTION] [COMMAND]

OPTION: 

    -h, --help
        Show this usage

"""
  print(usage_str%(sys.argv[0]))

def configs(argv) : 
  global MONTEMP, CPUTEMPMONGPIO, BG
  try : 
    opts, args = getopt.getopt(argv, "hbg:t:", ["help", "background", "gpio=", "temp="])
    for opt, arg in opts :
#      print("opt: %s, arg: %s"%(str(opt), str(arg)))
      if opt in ("-h", "--help") :
        usage()
      elif opt in ("-t", "--temp") :
        MONTEMP = float(arg) 
      elif opt in ("-g", "--gpio") :
        CPUTEMPMONGPIO = int(arg)
      elif opt in ("-b", "--background") :
        BG = 1
  except getopt.GetoptError : 
    print("getopt error!!\nbye...")
    sys.exit(2)
  info()

def info() :
  global MONTEMP, CPUTEMPMONGPIO
  info_str = """
  ############################################
  #  Monitor Temperature : %.3f
  #  Controlled GPIO     : %d
  #  Background Mode     : %d
  ############################################
"""
  print(info_str%(MONTEMP, CPUTEMPMONGPIO, BG))

def signal_int_handler(sig, frame):
#  print('\nYou pressed Ctrl+C!\nBye...')
  sys.exit(0)

def atexit_func() :
#  print("pid %d: exit!!"%(os.getpid()))
  syslog.closelog()

if __name__ == '__main__' :
  signal.signal(signal.SIGINT, signal_int_handler)
  atexit.register(atexit_func)
  configs(sys.argv[1:])
  syslog.openlog("%s"%(os.path.basename(sys.argv[0])), syslog.LOG_LOCAL0 | syslog.LOG_PID)
  main()


