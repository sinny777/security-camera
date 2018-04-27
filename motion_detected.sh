#!/bin/bash

deviceSerial=`cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2`

echo "Device Serial: $deviceSerial"

# curl -X POST -H "Content-Type: application/json" -d "{\"value1\":\"${deviceSerial}\"}" https://maker.ifttt.com/trigger/motion_detected/with/key/btF72fQ8puB6rda4-ANVvn

curl -X POST -H "Content-Type: application/json" -d "{\"deviceSerial\":\"${deviceSerial}\", \"event\":\"motion_detected\"}" http://api.hukamtechnologies.com/api/Notifications/trigger
