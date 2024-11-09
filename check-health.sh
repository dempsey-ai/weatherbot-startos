#!/bin/bash

# no actual logic here, just a placeholder to keep the healthcheck from timing out
# read DURATION
# if [ "$DURATION" -le 10000 ]; then
    #exit 60
# else
    #exit 0
# fi

# Check if Node.js process exists by looking in /proc for a cmdline containing "node"
NODE_RUNNING=$(find /proc -maxdepth 1 -type d -exec bash -c 'grep -l "node" {}/cmdline 2>/dev/null' \;)
if [ -z "$NODE_RUNNING" ]; then
    echo '{"status":"error","message":"Node.js process not found"}'
    exit 1
fi

# Test HTTPS connectivity to weather.gov
if ! curl --max-time 5 -sf https://api.weather.gov >/dev/null; then
    echo '{"status":"error","message":"Cannot connect to weather.gov API"}'
    exit 1
fi

# All checks passed
echo '{"status":"success","message":"weatherBot is running with API connectivity"}'
exit 0

