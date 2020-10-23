#!/bin/bash

hex2bin(){
  bin=$(echo "obase=2; ibase=16;$1" | bc )
  printf "%s" $bin
}


regbinmap(){
  bin=$(hex2bin $(/root/memtool -32 $1 1 | grep ":" | sed -e 's/^[^:]*:[ ]*//')) 
  
  count=$(printf "%s" $bin | wc -c)
  prepend=$(( 32 - $count ))
  printf "0%.0s" $(seq 1 1 $prepend)
  printf "%s" $bin
}

dumpreg(){
  printf "\n${1}:\n"
  for i in $(seq 31 -1 0); do 
    printf "%3d" $i
  done 
  echo 
  regbinmap $1 | sed -e 's/\([01]\)/  \1/g'
  printf "\n\n" 
}

#
# GPIO Registers Base : 7E215000 
#
# 0x00 GPFSEL0 GPIO Function Select 0 (0-9)
# 0x04 GPFSEL1 GPIO Function Select 1 (10-19)
# 0x08 GPFSEL2 GPIO Function Select 2 (20-29)
# 0x0C GPFSEL3 GPIO Function Select 3 (30-39) 
# 0x10 GPFSEL4 GPIO Function Select 4 (40-49) 
# 0x14 GPFSEL5 GPIO Function Select 5 (50-57) 
# 0x18 -Reserved-0x1CGPSET0 GPIO Pin Output Set 0  
# 0x20 GPSET1 GPIO Pin Output Set 1  
# 0x24 -Reserved- 0x28 GPCLR0 GPIO Pin Output Clear 0 320x2CGPCLR1 GPIO Pin Output Clear 1  
# 0x30 -Reserved- 0x34 GPLEV0 GPIO Pin Level 0  
# 0x38 GPLEV1 GPIO Pin Level 1

dumpreg 7E215004

