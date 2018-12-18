# Fork base code at https://github.com/futurice/android-jenkins-docker
# Modified, 2018-12-18

FROM jenkins/jenkins:2.150.1

MAINTAINER WindSekirun <pyxis@uzuki.live>

ENV ANDROID_SDK_ZIP sdk-tools-linux-4333796.zip
ENV ANDROID_SDK_ZIP_URL https://dl.google.com/android/repository/$ANDROID_SDK_ZIP
ENV ANDROID_HOME /opt/android-sdk-linux

ENV GRADLE_ZIP gradle-4.10.1-bin.zip
ENV GRADLE_ZIP_URL https://services.gradle.org/distributions/$GRADLE_ZIP

ENV PATH $PATH:$ANDROID_HOME/tools/bin
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:/opt/gradle-4.10.1/bin

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

RUN dpkg --add-architecture i386
RUN apt-get update && \
	apt-get install software-properties-common git unzip file -y

ADD $GRADLE_ZIP_URL /opt/
RUN unzip /opt/$GRADLE_ZIP -d /opt/ && \
	rm /opt/$GRADLE_ZIP

ADD $ANDROID_SDK_ZIP_URL /opt/
RUN unzip -q /opt/$ANDROID_SDK_ZIP -d $ANDROID_HOME && \
 	rm /opt/$ANDROID_SDK_ZIP

RUN	echo y | sdkmanager platform-tools \  
	"build-tools;28.0.3" \ 
	"platforms;android-28" \
	"build-tools;27.0.3" \ 
	"platforms;android-27" \
	"build-tools;26.0.3" \ 
	"platforms;android-26" \
	"extras;android;m2repository" && \
chown -R jenkins $ANDROID_HOME

RUN apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386 -y


RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
	
USER jenkins

RUN /usr/local/bin/install-plugins.sh git gradle android-emulator ws-cleanup slack embeddable-build-status
