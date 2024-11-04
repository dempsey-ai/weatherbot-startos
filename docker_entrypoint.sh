#!/bin/bash

set -a

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

printf "%s\n" "$SHELL"

APP_HOME="${APP_HOME:-/home/appuser/weatherbot}"
CLI_HOME="${CLI_HOME:-/home/appuser/cli}"
APP_DATA="${APP_DATA:-$APP_HOME/wx-bot-appdata}"
VOL_DATA="${VOL_DATA:-$APP_HOME/config}"

printf "Current OS user: %s\n" "$(whoami)"
# Get current username and change directory
CURRENT_USER=$(whoami)

cd $APP_HOME
# calls start9os_yamls.sh to create/update yamls and create/update weatherBot.env
start9os_yamls.sh


#while true; do
    # Load environment variables from weatherBot.env
    export $(cat weatherBot.env | grep -v '^#' | xargs)

    printf "Listing files in current directory and $APP_DATA\n"
    ls -l
    ls -l $APP_DATA

    # Start the first application with piped input
    if [ ! -f ./initcli.flag ] && [ ! -f "$APP_DATA/initcli.flag" ]; then
        printf "initcli.flag NOT found in both locations, starting wxBot first time\n"

        echo "wxBot" | $CLI_HOME/simplex-chat -l error -p ${SIMPLEX_CHAT_PORT:-5225} -d $APP_DATA/jed &
        FIRST_APP_PID=$!
        touch ./initcli.flag  # Create the flag file here
        touch $APP_DATA/initcli.flag
    else
        printf "Normal CLI start on port %s\n" "${SIMPLEX_CHAT_PORT:-5225}"
        $CLI_HOME/simplex-chat -l error -p ${SIMPLEX_CHAT_PORT:-5225} -d $APP_DATA/jed &
        FIRST_APP_PID=$!
    fi


    # Launch the WXBOT monitor script in background
    /usr/local/bin/watcher_wxbotenv.sh &

    # Store the monitor script's PID
    MONITOR_PID=$!


    printf "Starting wx-bot-chat.js\n"
    sleep 3
    # Try starting node application with retry
    MAX_RETRIES=2
    RETRY_COUNT=0
    while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
        node wx-bot-chat.js &
        SECOND_APP_PID=$!
        
        # Wait a moment to see if it stays running
        sleep 10
        if kill -0 $SECOND_APP_PID 2>/dev/null; then
            printf "wx-bot-chat.js started successfully\n"
            break
        else
            printf "wx-bot-chat.js failed to start, retrying...\n"
            RETRY_COUNT=$((RETRY_COUNT + 1))
            [ $RETRY_COUNT -lt $MAX_RETRIES ] && sleep 10
        fi
    done

    if [ $RETRY_COUNT -eq $MAX_RETRIES ]; then
        printf "Failed to start wx-bot-chat.js after %d attempts\n" "$MAX_RETRIES"
        exit 1
    fi

    # Wait for either application to exit
    wait -n $FIRST_APP_PID $SECOND_APP_PID

    # If either application exits, kill the other and restart both
    if kill -0 $FIRST_APP_PID 2>/dev/null; then
        kill $SECOND_APP_PID
        sleep 2
    else
        kill $FIRST_APP_PID
        sleep 2
    fi
   
	printf "Exiting wxBot\n"
	

#done

