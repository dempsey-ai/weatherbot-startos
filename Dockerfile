### Start9os stage
FROM dempsey0ai/weatherbot:1.1

# Set environment variables
ENV HOME=/home/appuser
ENV APP_HOME=$HOME/weatherbot
ENV APP_DATA=$APP_HOME/wx-bot-appdata \
    CLI_HOME=$HOME/cli \
    VOL_DATA=$APP_HOME/config \
    WXBOT="unknown"

#RUN useradd -m -d $HOME -s /bin/bash appuser
#RUN chown -R appuser:appuser $HOME $APP_HOME $CLI_HOME


USER root

RUN apt-get update && \
    apt-get install -y wget && \
    wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && \
    chmod +x /usr/bin/yq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


COPY ./check-health.sh /usr/local/bin/check-health.sh
RUN chmod a+x /usr/local/bin/check-health.sh

COPY ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/docker_entrypoint.sh

COPY ./start9os_yamls.sh /usr/local/bin/start9os_yamls.sh
RUN chmod a+x /usr/local/bin/start9os_yamls.sh


# Allow console output to be seen outside the container
STOPSIGNAL SIGTERM

