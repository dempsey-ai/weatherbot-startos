#!/bin/sh

set -e 

mkdir -p /mnt/backup/data
compat duplicity create /mnt/backup/data /home/appuser/weatherbot/wx-bot-appdata
