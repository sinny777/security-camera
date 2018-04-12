#!/bin/bash

if [ "" != "$1" ]; then
    ACTION=$1;
fi

if [ "" != "$2" ]; then
    SECRET=$2;
fi

if [ "$ACTION" == "motion" ]; then
     PID=`ps -aef | grep raspivid | grep -v sh| grep -v grep| awk '{print $2}'`
    if [ -z "$PID" ]; then
      echo "raspivid process is not running"
    else
      # kill -9 $PID
      pkill raspivid
      echo "raspivid process killed forcefully, process id $PID."
    fi
   motion
   # Check if service is running
   service motion status
   # Let's monitor motion.log to keep this script and container running
   tail -F /tmp/motion/motion.log
elif [ "$ACTION" == "live" ]; then
   PID=`ps -aef | grep motion | grep -v sh| grep -v grep| awk '{print $2}'`
   if [ -z "$PID" ]; then
     echo "motion process is not running"
   else
     service motion stop
     echo "motion service stopped, process id $PID."
   fi
   raspivid -o - -t 0 -w 1920 -h 1080 -fps 40 -b 8000000 -g 40 --vflip | ffmpeg -re -ar 44100 -ac 2 -acodec pcm_s16le -f s16le -ac 2 -i /dev/zero -f h264 -i pipe:0 -c:v copy -c:a aac -ab 128k -g 40 -strict experimental -f flv -r 30 rtmp://a.rtmp.youtube.com/live2/$SECRET
   echo "Live Feed started $SECRET."
else
   echo "Unkown parameters"
   motion
   # Check if service is running
   service motion status
fi
