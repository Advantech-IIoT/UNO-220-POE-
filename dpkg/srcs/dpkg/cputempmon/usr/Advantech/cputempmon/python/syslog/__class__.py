import syslog

class syslog: 
  def __init__(self, **argv): 
    self.argv = {
    }
    for k, v in argv.items(): 
      self.argv[k] = v
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
