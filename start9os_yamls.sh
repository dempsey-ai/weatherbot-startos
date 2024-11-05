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

APP_DATA=$APP_HOME/wx-bot-appdata

if [ ! -d $START9_HOME ]; then
  printf "start9 home directory not found, creating\n"
  mkdir -p $START9_HOME
fi

if [ "$initHostUser" == "" ]; then
  printf "initHostUser not set, use WXBOT to connect Host User to weatherBot\n"
  initHostUser=""
else
  printf "initHostUser set prior to checking config.yaml, using $initHostUser to connect Host User to weatherBot\n"
fi

# User Config
if [ ! -f $START9_HOME/config.yaml ]; then
printf "Creating missing config.yaml\n"
cat <<EOP > $START9_HOME/config.yaml
version: 2
data:
  debug-mode:
    type: boolean
    value: $DEBUG_MODE
    description: Enable additional console logging
    copyable: true
    masked: false
    qr: false
  simplex-chat-port:
    type: number
    value: $SIMPLEX_CHAT_PORT
    description: Port number for Simplex Chat connection
    copyable: true
    masked: false
    qr: false
  summer-temp-hot:
    type: number
    value: $summerTempHot
    description: Temperature threshold for hot weather during summer months
    copyable: true
    masked: false
    qr: false
  temp-hot:
    type: number
    value: $tempHot
    description: Temperature threshold for hot weather during non-summer months
    copyable: true
    masked: false
    qr: false
  temp-cold:
    type: number
    value: $tempCold
    description: Temperature threshold for cold weather year-round
    copyable: true
    masked: false
    qr: false
  share-bot-address:
    type: boolean
    value: $shareBotAddress
    description: Allow users to share the weatherBot profile address with others
    copyable: true
    masked: false
    qr: false
  init-host-user:
    type: string
    value: $initHostUser
    description: Simplex user address for initial host/admin user
    copyable: true
    masked: false
    qr: true
EOP
else
  printf "config.yaml exists, updating weatherBot.env\n"
  cat $START9_HOME/config.yaml


  #source $START9_HOME/config.yaml
  DEBUG_MODE=$(yq e '.debug-mode' $START9_HOME/config.yaml)
  SIMPLEX_CHAT_PORT=$(yq e '.simplex-chat-port // 5225' $START9_HOME/config.yaml)
  summerTempHot=$(yq e '.summer-temp-hot' $START9_HOME/config.yaml)
  tempHot=$(yq e '.temp-hot' $START9_HOME/config.yaml)
  tempCold=$(yq e '.temp-cold' $START9_HOME/config.yaml)
  shareBotAddress=$(yq e '.share-bot-address' $START9_HOME/config.yaml)
  initHostUser=$(yq e '.init-host-user' $START9_HOME/config.yaml)


  if [ "$initHostUser" == "" ]; then
  printf "initHostUser not set after config.yaml, use WXBOT to connect Host User to weatherBot\n"
  initHostUser=""
else
  printf "initHostUser found in config.yaml, using [simplex address] to connect Host User to weatherBot\n"
fi
  

  if [[ "$initHostUser" =~ ^\".*\"$ ]]; then
    echo "initHostUser value already has quotes."
  else
    initHostUser="$initHostUser"
  fi


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
  WXBOT=unknown
else
  printf "wxBot user profile exists, updating $START9_HOME/stats.yaml\n"
  source $APP_DATA/wxbot.env
fi

if [[ "$WXBOT" =~ ^\".*\"$ ]]; then
    printf "WXBOT value already has quotes, removing quotes for properties yaml. \n"
    WXBOT="${WXBOT#\"}"  # Remove first quote
  WXBOT="${WXBOT%\"}"  # Remove last quote
fi 

printf "creating $START9_HOME/stats.yaml\n"
# Properties Page
cat > $START9_HOME/stats.yaml <<EOF
version: 2
data:
  wxBot Address:
    type: string
    value: $WXBOT
    description: The weatherBot SimpleX profile address to share with others
    copyable: true
    masked: false
    qr: true
  Initial Host User:
    type: string
    value: $initHostUser
    description: The Simplex user address for initial host/admin user (initial authorized user for weatherBot)
    copyable: true
    masked: false
    qr: true
EOF

printf "stats.yaml created\n"
cat $START9_HOME/stats.yaml

exit 0
