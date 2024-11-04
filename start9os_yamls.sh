#!/bin/bash

set -ea


if [ ! -f $APP_HOME/weatherBot.env ]; then
  printf "weatherBot.env not found, creating\n"
  # copy from .env-template
  cp $APP_HOME/.env-template $APP_HOME/weatherBot.env
fi

# Environment Variables
source $APP_HOME/weatherBot.env
HOME="${HOME:-/home/appuser}"
APP_HOME="${APP_HOME:-$HOME/weatherbot}"
CLI_HOME="${CLI_HOME:-$HOME/.local/bin}"
APP_DATA="${APP_DATA:-$APP_HOME/wx-bot-appdata}"
START9_HOME="${START9_HOME:-/root/start9}"

if [ ! -d $START9_HOME ]; then
  printf "start9 home directory not found, creating\n"
  mkdir -p $START9_HOME
fi

# User Config
if [ ! -f $START9_HOME/config.yaml ]; then
printf "Creating missing config.yaml\n"
cat <<EOP > $START9_HOME/config.yaml
version: 2
data:
  DEBUG_MODE:
    type: boolean
    value: $DEBUG_MODE
    description: Enable additional console logging
    copyable: true
    masked: false
    qr: false
  APP_DATA:
    type: string
    value: $APP_DATA
    description: Directory for environment specific application data
    copyable: true
    masked: false
    qr: false
  SIMPLEX_CHAT_PORT:
    type: number
    value: $SIMPLEX_CHAT_PORT
    description: Port number for Simplex Chat connection
    copyable: true
    masked: false
    qr: false
  summerTempHot:
    type: number
    value: $summerTempHot
    description: Temperature threshold for hot weather during summer months
    copyable: true
    masked: false
    qr: false
  tempHot:
    type: number
    value: $tempHot
    description: Temperature threshold for hot weather during non-summer months
    copyable: true
    masked: false
    qr: false
  tempCold:
    type: number
    value: $tempCold
    description: Temperature threshold for cold weather year-round
    copyable: true
    masked: false
    qr: false
  shareBotAddress:
    type: boolean
    value: $shareBotAddress
    description: Allow users to share the weatherBot profile address with others
    copyable: true
    masked: false
    qr: false
  initHostUser:
    type: string
    value: $initHostUser
    description: Simplex user address for initial host/admin user
    copyable: true
    masked: false
    qr: true
EOP
else
  printf "config.yaml exists, updating weatherBot.env\n"
  #source $START9_HOME/config.yaml
  DEBUG_MODE=$(grep 'DEBUG_MODE' $START9_HOME/config.yaml | cut -d ' ' -f 2)
  APP_DATA="\"$(grep 'APP_DATA' $START9_HOME/config.yaml | cut -d ' ' -f 2)\""
  SIMPLEX_CHAT_PORT=$(grep 'SIMPLEX_CHAT_PORT' $START9_HOME/config.yaml | cut -d ' ' -f 2 || echo "5225")
  summerTempHot=$(grep 'summerTempHot' $START9_HOME/config.yaml | cut -d ' ' -f 2)
  tempHot=$(grep 'tempHot' $START9_HOME/config.yaml | cut -d ' ' -f 2)
  tempCold=$(grep 'tempCold' $START9_HOME/config.yaml | cut -d ' ' -f 2)
  shareBotAddress=$(grep 'shareBotAddress' $START9_HOME/config.yaml | cut -d ' ' -f 2)
  initHostUser="\"$(grep 'initHostUser' $START9_HOME/config.yaml | cut -d ' ' -f 2 || echo "")\""

  cat <<EOP > $APP_HOME/weatherBot.env
DEBUG_MODE=$DEBUG_MODE
APP_DATA=$APP_DATA
SIMPLEX_CHAT_PORT=$SIMPLEX_CHAT_PORT
summerTempHot=$summerTempHot
tempHot=$tempHot
tempCold=$tempCold
shareBotAddress=$shareBotAddress
initHostUser=$initHostUser
EOP
fi


if [ ! -f $APP_DATA/wxbot.env ]; then 
  printf "wxBot user profile not yet created\n"
  WXBOT=""
else
  printf "wxBot user profile exists, updating stats.yaml\n"
  source $APP_DATA/wxbot.env
fi
# Properties Page
cat <<EOP > $START9_HOME/stats.yaml
version: 2
data:
  wxBot Address:
    type: string
    value: "$WXBOT"
    description: The weatherBot SimpleX profile address to share with others
    copyable: true
    masked: false
    qr: true
  Initial Host User:
    type: string
    value: "$initHostUser"
    description: The Simplex user address for initial host/admin user (initial authorized user for weatherBot)
    copyable: true
    masked: false
    qr: true
EOP

exit 0
