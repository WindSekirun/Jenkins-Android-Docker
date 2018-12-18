# Fork base code at https://github.com/futurice/android-jenkins-docker
# Modified, 2018-12-18

# Jenkins comes with JDK8
FROM jenkins

# Set desired Android Linux SDK version
ENV ANDROID_SDK_VERSION 24.4.1

ENV ANDROID_SDK_ZIP android-sdk_r$ANDROID_SDK_VERSION-linux.tgz
ENV ANDROID_SDK_ZIP_URL https://dl.google.com/android/$ANDROID_SDK_ZIP
ENV ANDROID_HOME /opt/android-sdk-linux

ENV GRADLE_ZIP gradle-4.10.1-bin.zip
ENV GRADLE_ZIP_URL https://services.gradle.org/distributions/$GRADLE_ZIP

ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:/opt/gradle-4.10.1/bin

USER root

# Init dependencies for the setup process
RUN dpkg --add-architecture i386
RUN apt-get update && \
	apt-get install software-properties-common git unzip -y

# Install gradle
ADD $GRADLE_ZIP_URL /opt/
RUN unzip /opt/$GRADLE_ZIP -d /opt/ && \
	rm /opt/$GRADLE_ZIP

# Install Android SDK
ADD $ANDROID_SDK_ZIP_URL /opt/
RUN tar xzvf /opt/$ANDROID_SDK_ZIP -C /opt/ && \
	rm /opt/$ANDROID_SDK_ZIP

# Install required build-tools
RUN	echo "y" | android update sdk -u -a --filter platform-tools,android-23,build-tools-23.0.3 && \
	chmod -R 755 $ANDROID_HOME
RUN	echo "y" | android update sdk -u -a --filter platform-tools,android-25,build-tools-25.0.3 && \
	chmod -R 755 $ANDROID_HOME
RUN	echo "y" | android update sdk -u -a --filter platform-tools,android-26,build-tools-26.0.3 && \
	chmod -R 755 $ANDROID_HOME
RUN	echo "y" | android update sdk -u -a --filter platform-tools,android-27,build-tools-27.0.3 && \
	chmod -R 755 $ANDROID_HOME
RUN	echo "y" | android update sdk -u -a --filter platform-tools,android-28,build-tools-28.0.3 && \
	chmod -R 755 $ANDROID_HOME
RUN echo "y" | android update sdk -u -a --filter extra-android-m2repository
RUN echo "y" | android update sdk -u -a --filter extra-google-m2repository

# Install 32-bit compatibility for 64-bit environments
RUN apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386 -y

# Cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
	
USER jenkins

# List desired Jenkins plugins here
RUN /usr/local/bin/install-plugins.sh git gradle
