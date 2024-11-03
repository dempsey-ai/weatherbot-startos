#!/bin/sh

set -e 

compat duplicity restore /mnt/backup/data /home/appuser/weatherbot/wx-bot-appdata
