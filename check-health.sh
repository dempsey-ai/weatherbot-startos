#!/bin/bash

# no actual logic here, just a placeholder to keep the healthcheck from timing out
read DURATION
if [ "$DURATION" -le 10000 ]; then
    exit 60
else
    exit 0
fi
