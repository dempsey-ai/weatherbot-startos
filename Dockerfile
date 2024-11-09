# This Dockerfile is used to build the weatherbot package for Start9OS
# It utilized during the start-sdk build process 'make x86' in this case
# The upstream image was built with start9os in mind so there are few changes needed at this point
# The upstream image can run on its own but also uses the same 
# docker entrypoint script logic and config and stats yaml files to simplify this part.
# The majority of the work at this point was figuring out the manifest and makefile components.

### Start9os stage
FROM dempsey0ai/weatherbot:wgov-1.2

USER root

# Set environment variables
ENV HOME=/home/appuser
ENV APP_HOME=$HOME/weatherbot
ENV APP_DATA=$APP_HOME/wx-bot-appdata \
    CLI_HOME=$HOME/cli \
    START9_HOME=/root/start9
ENV YAML_DATA=$START9_HOME


COPY ./check-health.sh /usr/local/bin/check-health.sh
RUN chmod a+x /usr/local/bin/check-health.sh

RUN cp $APP_HOME/weatherBot.sh /usr/local/bin/docker_entrypoint.sh && \
    chmod a+x /usr/local/bin/docker_entrypoint.sh

RUN yq -i '.data."app-host".value = "start9"' $APP_HOME/wx-bot-weatherbot.yaml
RUN yq -i ".data.\"user-home\".value = \"$HOME\"" $APP_HOME/wx-bot-weatherbot.yaml && \
    yq -i ".data.\"app-home\".value = \"$APP_HOME\"" $APP_HOME/wx-bot-weatherbot.yaml && \
    yq -i ".data.\"yamls-path\".value = \"$YAML_DATA\"" $APP_HOME/wx-bot-weatherbot.yaml && \
    yq -i ".data.\"data-path\".value = \"$APP_HOME/wx-bot-appdata\"" $APP_HOME/wx-bot-weatherbot.yaml

# review the primary app yaml file for the changes we made above
RUN cat $APP_HOME/wx-bot-weatherbot.yaml

# Allow console output to be seen outside the container
STOPSIGNAL SIGTERM

