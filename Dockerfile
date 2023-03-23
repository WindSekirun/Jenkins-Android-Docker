#Based Image
FROM jenkins/jenkins:latest-jdk11

## Define Environment
LABEL maintainer="stilesting@gmail.com"

ENV ANDROID_SDK_ZIP commandlinetools-linux-6609375_latest.zip
ENV ANDROID_SDK_ZIP_URL https://dl.google.com/android/repository/$ANDROID_SDK_ZIP
ENV ANDROID_HOME /opt/android-sdk-linux
ENV ANDROID_SDK_ROOT /opt/android-sdk-linux

ENV GRADLE_ZIP gradle-6.5-bin.zip
ENV GRADLE_ZIP_URL https://services.gradle.org/distributions/$GRADLE_ZIP

ENV PATH $PATH:$ANDROID_SDK_ROOT/tools/bin
ENV PATH $PATH:$ANDROID_SDK_ROOT/platform-tools
ENV PATH $PATH:/opt/gradle-6.5/bin

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
          org.label-schema.name="Jenkins-Android-Docker" \
          org.label-schema.description="Docker image for Jenkins with Android " \
          org.label-schema.vcs-ref=$VCS_REF \
          org.label-schema.vcs-url="https://github.com/WindSekirun/Jenkins-Android-Docker" \
          org.label-schema.vendor="WindSekirun" \
          org.label-schema.version=$VERSION \
          org.label-schema.schema-version="1.0"

USER root

## Install requirements
RUN dpkg --add-architecture i386
RUN rm -rf /var/lib/apt/list/* && apt-get update && apt-get install ca-certificates curl gnupg2 software-properties-common git unzip file apt-utils lxc apt-transport-https libc6:i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386 -y

## Install Docker-ce into Image
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey;
RUN apt-key add /tmp/dkey
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
RUN apt-get update && apt-get install docker-ce -y --no-install-recommends
RUN usermod -a -G docker jenkins

## Install Android SDK into Image
ADD $GRADLE_ZIP_URL /opt/
RUN unzip /opt/$GRADLE_ZIP -d /opt/ && rm /opt/$GRADLE_ZIP

ADD $ANDROID_SDK_ZIP_URL /opt/
RUN unzip -q /opt/$ANDROID_SDK_ZIP -d $ANDROID_SDK_ROOT && rm /opt/$ANDROID_SDK_ZIP

RUN echo yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" "build-tools;30.0.2"
RUN echo yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" "platforms;android-30"
RUN echo yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" "build-tools;29.0.3"
RUN echo yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" "platforms;android-29"
RUN echo yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" "build-tools;28.0.3"
RUN echo yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" "platforms;android-28"
RUN echo yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" "build-tools;27.0.3"
RUN echo yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" "platforms;android-27"
RUN echo yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" "build-tools;26.0.3"
RUN echo yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" "platforms;android-26"

RUN chown -R jenkins $ANDROID_SDK_ROOT

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Install Jenkins plugin	
USER jenkins

RUN jenkins-plugin-cli --plugins git gradle android-emulator ws-cleanup slack embeddable-build-status blueocean github-coverage-reporter jacoco github-pr-coverage-status locale