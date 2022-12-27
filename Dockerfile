ARG OPENJDK_VERSION=8-slim
ARG NODE_VERSION=16.19.0

FROM openjdk:${OPENJDK_VERSION}

ARG NODE_VERSION

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && \
    apt-get install curl wget zip unzip -y && \
    apt-get -y autoclean;


ENV NVM_DIR /usr/local/nvm

RUN echo "-k" > ~/.curlrc && \
    mkdir -p $NVM_DIR && \
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash && \
    source $NVM_DIR/nvm.sh && \
    nvm install ${NODE_VERSION} && \
    nvm alias default ${NODE_VERSION} && \
    nvm use default

# add node and npm to path so the commands are available
ENV PATH=$NVM_DIR/versions/node/v${NODE_VERSION}/bin/:${PATH}

# confirm installation
RUN node -v && \
    npm -v && \
    java -version

ENV ANDROID_HOME=/opt/android

RUN mkdir -p $ANDROID_HOME && \
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip -O $ANDROID_HOME/cmdline-tools.zip && \
    unzip -q $ANDROID_HOME/cmdline-tools.zip -d $ANDROID_HOME/ && \
    rm $ANDROID_HOME/cmdline-tools.zip
