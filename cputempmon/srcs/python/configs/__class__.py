import os, sys, getopt 

class configs:
  def __init__(self, **argv): 
    self.argv = {
      'name' : 'cputempmon',
      'pidfile' : "./configs.pid", 
      'bg' : 0,
      'debug' : 0, 
      'temp' : 50.0, 
      'gpio' : 12, 
      'time' : 5, 
      'usage' : self.usage, 
      'info' : self.info
    }
    for k, v in argv.items(): 
      self.argv[k] = v
    if self['debug'] == 1 : 
      self.info()
  def __setitem__(self,k,v): 
    self.argv[k] = v
  def __getitem__(self,k): 
    if self.argv.has_key(k) : 
      return self.argv[k]
    else:
      return None
  def getopt(self, argv): 
    try : 
      opts, args = getopt.getopt(argv, "?hbkd:T:t:p:g:", ["help", "background", "stop", "debug=", "time=", "gpio=", "temp=", "pidfile="])
      for opt, arg in opts :
        # print("opt: %s, arg: %s"%(str(opt), str(arg)))
        if opt in ("-h", "-?", "--help") :
          self['usage']()
        elif opt in ("-t", "--temp") :
          self['temp'] = float(arg) 
        elif opt in ("-g", "--gpio") :
          self['gpio'] = int(arg)
        elif opt in ("-p", "--pidfile") :
          self['pidfile'] = str(arg)
        elif opt in ("-T", "--time") :
          self['time'] = int(arg)
        elif opt in ("-d", "--debug") :
          self['debug'] = int(arg)
        elif opt in ("-k", "--stop") :
          self['stop']()
          sys.exit(0)
        elif opt in ("-b", "--background") :
          self['bg'] = 1
    except getopt.GetoptError : 
      print("getopt error!!\nbye...")
      sys.exit(2)
    if self['debug'] == 1 : 
      self['info']()
  def usage(self):
    usage_str="""
                                                           
  Usage:                                                   
     %s [OPTION]
                                                           
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
      Default: GPIO%d                                      
    -t, --temp [number]                                    
      Set warning temperature.                             
      Default: 50.0 C                                      
    -T, --time [number]                                    
      Set pooling time.                                    
      Default: 5 sec                                       
    -p, --pidfile [path]                                   
      Set pid file                                         
      Default: %s                                          
                                                           
"""
    print(usage_str%(self['name'], self['gpio'], self['pidfile']))
    sys.exit(0)
  def info(self):
    print("%s: "%(self['name']));
    for k, v in self.argv.items(): 
      print("  %s : %s"%(str(k), str(v)))

__all__ = ['configs']
