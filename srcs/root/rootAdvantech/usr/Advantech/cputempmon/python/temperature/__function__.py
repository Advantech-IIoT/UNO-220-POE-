
import os

def get(zone="thermal_zone0"):
  fd = os.open("/sys/class/thermal/%s/temp"%(zone), os.O_RDONLY)
  s = os.read(fd, 64)
  temp = (int(s)/1000.0)
  os.close(fd)
  return temp

