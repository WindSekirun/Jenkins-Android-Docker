# Jenkins-Android-Docker
[![](https://images.microbadger.com/badges/image/windsekirun/jenkins-android-docker.svg)](https://microbadger.com/images/windsekirun/jenkins-android-docker "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/windsekirun/jenkins-android-docker.svg)](https://microbadger.com/images/windsekirun/jenkins-android-docker "Get your own version badge on microbadger.com") 

🐳 Docker image for Jenkins with Android

Fork base code at [futurice/android-jenjins-docker](https://github.com/futurice/android-jenkins-docker), Revised to the latest development environment.

## Pre-installed SDK Version

 * Android API 28 - build tools 28.0.3
 * Android API 27 - build tools 27.0.3
 * Android API 26 - build tools 26.0.3
 * extra-android-m2repository
 
## Pre-installed Jenkins Plugin
 
  * git
  * gradle
  * android-emulator
  * ws-cleanup
  * slack
  * embeddable-build-status
  
## Build image
```docker build -t jenkins-android-docker .```

## Use image
```docker run -p 8080:8080 -p 50000:50000 -v /data/jenkins-android-docker:/var/jenkins_home windsekirun/jenkins-android-docker:<latest-version>```

Latest version need to replace real version. You can find tag in [this page](https://hub.docker.com/r/windsekirun/jenkins-android-docker/tags)
 
## Modification
 From Line 33 ~ 41, you can modify version info using `sdkmanager`. Feel free to change these value.
 
## ~License~
 ~Do we really need license?~
