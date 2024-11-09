#!/bin/sh

set -e 

# Create backup directories
mkdir -p /mnt/backup/data
mkdir -p /mnt/backup/config

# Backup application data
compat duplicity create /mnt/backup/data /home/appuser/weatherbot/wx-bot-appdata

# Backup configuration data
compat duplicity create /mnt/backup/config /root/start9
