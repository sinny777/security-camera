#!/bin/bash

motion

# Start motion
# /etc/init.d/motion restart

# service motion restart

# Check if service is running
service motion status

# Let's monitor motion.log to keep this script and container running
tail -F /tmp/motion/motion.log
