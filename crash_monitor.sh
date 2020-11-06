#!/bin/bash

d=`date '+%F %T'`;
num=`ps fax | grep '/ttnode' | egrep -v 'grep|echo|rpm|moni|guard' | wc -l`;
echo $num;
if [ $num -lt 1 ];then
 echo "[$d] ttnode is dead...restarting" >> /usr/node/log.log ;
 echo "[$d] ttnode is dead...restarting";
 mount -o,remount,rw LABEL=428050 /mnts
 /usr/node/ttnode -p /mnts;
fi