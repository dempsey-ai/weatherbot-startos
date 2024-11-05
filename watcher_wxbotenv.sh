#!/bin/bash
source ~/.bashrc

set -a


APP_DATA="${APP_DATA:-$APP_HOME/wx-bot-appdata}"
START9_HOME="${START9_HOME:-/root/start9}"

# Path to the file we're waiting for
WATCH_FILE="$APP_DATA/wxbot.env"
STATS_FILE="$START9_HOME/stats.yaml"
CHATS="n/a"

MAX_ATTEMPTS=120  # 120 * 5 seconds = 600 seconds = 10 minutes
attempt=1

while [ $attempt -le $MAX_ATTEMPTS ]; do
    if [ -f "$WATCH_FILE" ]; then
        # Read necessary values from the file
        #SOME_VALUE=$(cat "$WATCH_FILE")
        # source $WATCH_FILE
        # Read the file and ensure line ending
        WXBOT=$(cat "$WATCH_FILE" | sed 's/^WXBOT=//')

        # Debug output
        printf "WXBOT value after source: %s\n" "$WXBOT"

        if [ -n "$WXBOT" ]; then
        
          # Create stats.yaml
          if [[ "$WXBOT" =~ ^\".*\"$ ]]; then
              printf "WXBOT value already has quotes, removing quotes for properties yaml. \n"
              WXBOT="${WXBOT#\"}"  # Remove first quote
              WXBOT="${WXBOT%\"}"  # Remove last quote
          fi    

          yq -i '.data["wxBot Address"].value = strenv(WXBOT)' "${STATS_FILE}"
          printf "Successfully created stats.yaml after %d attempts\n" "$attempt"
          exit 0
        fi  
    fi
    
    printf "Attempt %d of %d: Waiting for %s...\n" "$attempt" "$MAX_ATTEMPTS" "$WATCH_FILE"
    sleep 5
    ((attempt++))
done

printf "Timed out waiting for $WATCH_FILE after $MAX_ATTEMPTS attempts\n"



exit 0  # Exit regardless of success or failure

