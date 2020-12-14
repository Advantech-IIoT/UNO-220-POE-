#!/bin/bash
echo init.sh start!!!!
mkdir -p /overlay/{upper,work,merged}
modprobe overlay
mount -t overlay overlay -o lowerdir=/,upperdir=/overlay/upper,workdir=/overlay/work /overlay/merged
mkdir -p /overlay/merged/old
echo before init...
sleep 3
exec bash
# cd /overlay/merged
# pivot_root . old
# exec chroot . /sbin/init
