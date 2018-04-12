#!/bin/bash

docker stop camera
docker rm camera

if [ "" != "$1" ]; then
    ACTION=$1;
fi

if [ "" != "$2" ]; then
    SECRET=$2;
fi

if [ "$ACTION" == "motion" ]; then
    docker run --privileged -it -d --name camera -p 9090:9090 -p 9091:9091 -v /tmp:/tmp --device=/dev/video0 hukam/security-camera motion
elif [ "$ACTION" == "live" ]; then
   docker run --privileged -it -d --name camera -p 9090:9090 -p 9091:9091 -v /tmp:/tmp --device=/dev/video0 hukam/security-camera live $SECRET
   echo "Live Feed started $SECRET."
else
   echo "Unkown parameters"
   docker run --privileged -it -d --name camera -p 9090:9090 -p 9091:9091 -v /tmp:/tmp --device=/dev/video0 hukam/security-camera motion
fi
