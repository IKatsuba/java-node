ARG JAVA_NODE_VERSION

FROM timbru31/java-node:$JAVA_NODE_VERSION

RUN apt-get update && \
    apt-get install wget -y && \
    apt-get install zip unzip -y && \
    apt-get clean;

ENV ANDROID_HOME=/opt/android

RUN mkdir -p $ANDROID_HOME && \
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip -O $ANDROID_HOME/cmdline-tools.zip && \
    unzip -q $ANDROID_HOME/cmdline-tools.zip -d $ANDROID_HOME/ && \
    rm $ANDROID_HOME/cmdline-tools.zip
