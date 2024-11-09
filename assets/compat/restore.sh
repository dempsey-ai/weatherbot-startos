#!/bin/sh

set -e 

# Restore application data
compat duplicity restore /mnt/backup/data /home/appuser/weatherbot/wx-bot-appdata

# Restore configuration data
compat duplicity restore /mnt/backup/config /root/start9
