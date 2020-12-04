import os, sys, re, time
def check_gpio_sysfs() :
  ret = os.access("/sys/kernel/debug/gpio", os.R_OK)
  if ret == False: 
    print("No permission for gpio sysfs...")
    print("Bye. ")
    sys.exit(1)
#  else: 
#    print("access gpio sysfs: ready")

def control(on, led) : 
  os.system("echo %d > /sys/class/gpio/gpio%d/value"%(on, led));

def init(led) :
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
  # for i in range(5) : 
  #   control(0, led)
  #   time.sleep(0.1)
  #   control(1, led)
  #   time.sleep(0.1)
  control(0, led)

__all__ = ['check_gpio_sysfs', 'control', 'init']
