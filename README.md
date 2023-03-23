# Jenkins-Android-Docker
[![](https://images.microbadger.com/badges/image/windsekirun/jenkins-android-docker.svg)](https://microbadger.com/images/windsekirun/jenkins-android-docker "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/windsekirun/jenkins-android-docker.svg)](https://microbadger.com/images/windsekirun/jenkins-android-docker "Get your own version badge on microbadger.com") 

Docker image for Jenkins with Android, [View on DockerHub](https://hub.docker.com/r/windsekirun/jenkins-android-docker)

Fork base code at [futurice/android-jenkins-docker](https://github.com/futurice/android-jenkins-docker), Revised to the latest development environment.

## Pre-installed packages
 * Jenkins Version: 2.266
 * Docker-CE 

### Android SDK
 * Android API 30 - build tools 30.0.02 (1.1.3)
 * Android API 29 - build tools 29.0.2 (1.0.8)
 * Android API 28 - build tools 28.0.3
 * Android API 27 - build tools 27.0.3
 * Android API 26 - build tools 26.0.3
 
### Jenkins Plugin
 * git
 * gradle
 * android-emulator
 * ws-cleanup
 * slack
 * embeddable-build-status
 * blueocean (1.0.4)
 * github-coverage-reporter (1.0.4)
 * jacoco (1.0.4)
 * github-pr-coverage-status (1.0.4)
 * locale (1.0.6)
  
## Build image
```docker build -t jenkins-android-docker .```

Instead, you can use `buildImage.sh`

## Using image
```docker run -d -p 8080:8080 -p 50000:50000 -v /data/jenkins-android-docker:/var/jenkins_home windsekirun/jenkins-android-docker:<latest-version>```

 - Latest version need to replace real version. You can find tag in [Release Page](https://github.com/WindSekirun/Jenkins-Android-Docker/releases)
 - Before run image, you should provide permission to access /data/jenkins-android-docker with ```sudo chown -R 1000:1000 /data/jenkins-android-docker``` statement.

### docker
```
docker run -dit -p 8080:8080 --dns 8.8.8.8 -p 50000:50000 -v /data/jenkins:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v /etc/localtime:/etc/localtime --name jenkins stilesboy/jenkins-android-java11:v1.0
```

### With nginx
If you want use nginx for reverse-proxy, you can add this statement in conf file.
```proxy_pass http://jenkins:8080;```

## Modification
 From Line 52, you can modify version info using `sdkmanager`. Feel free to change these value.
 
## ~License~
 ~Do we really need license?~
