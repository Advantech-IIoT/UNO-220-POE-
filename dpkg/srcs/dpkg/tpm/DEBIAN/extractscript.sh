#!/bin/bash
extractscript=preinst
# remove the lines after exit
sed -ne '1{h;b label3;}; /^exit/{ b label1 H;g;p;b label3;}; b label2; :label1 {H;g;p;}; :label2 H; :label3;' -i ${extractscript}
# append packed file to script
tar -C ./root --numeric-owner -zcpf - . >> ${extractscript}
