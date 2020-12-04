import os, sys, time, signal, atexit

def signal_int_handler(sig, frame):
  sys.exit(0)

class fork: 
  def __init__(self, **argv): 
    self.argv = {
      'pidfile' : "/var/run/fork-py.pid", 
      'bg' : 0,
      'debug' : 0, 
      'info' : self.info
    }
    for k, v in argv.items(): 
      self.argv[k] = v
    if self['debug'] == 1 : 
      self.info()
    # atexit.register(self.atexit_func)
  def atexit_func(self) : 
    print("atexit_func()")
    if os.access(self['pidfile'], os.F_OK) == True : 
      os.remove(self['pidfile'])
  def __setitem__(self,k,v): 
    self.argv[k] = v
  def __getitem__(self,k): 
    if self.argv.has_key(k) : 
      return self.argv[k]
    else:
      return None
  def info(self) : 
    print("################################")
    for k, v in self.argv.items() :
      print("  %s : %s"%(k, v))
    print("################################")
  def appendpid(self) :
    if os.access(self['pidfile'], os.W_OK) : 
      fp = file(self['pidfile'], "a+")
      fp.write("%s\n"%(str(os.getpid())))
      fp.close()
    else :
      print("No permission to create pidfile - '%s'. "%(self['pidfile']))
      print('Bye. ');
      sys.exit(1)
  def run(self, bg=0):
    if os.access(self['pidfile'], os.F_OK) == True : 
      os.remove(self['pidfile'])
    signal.signal(signal.SIGINT, signal_int_handler)
    if os.fork() == 0 : 
      if self['child'] : 
        self.appendpid()
        while True == True : 
          self['child']()
    else:
      if bg == 1 : 
        print("Enter background mode...")
        return
      else:
        self.appendpid()
        if self['parent'] : 
          while True == True : 
            self['parent']()
  def stop(self) :
    if os.access(self['pidfile'], os.F_OK) == True : 
      os.system("cat %s | xargs kill -9 > /dev/null 2>&1"%(self["pidfile"]))
      os.remove(self['pidfile'])

__all__ = ['fork']
