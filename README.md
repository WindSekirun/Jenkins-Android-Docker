# Jenkins-Android-Docker
🐳 Docker image for Jenkins with Android

Fork base code at https://github.com/futurice/android-jenkins-docker , modified in now-days environment.

## Pre-installed SDK Version

 * Android API 28 - build tools 28.0.3
 * Android API 27 - build tools 27.0.3
 * Android API 26 - build tools 26.0.3
 * extra-android-m2repository
 
 ## Pre-installed Plugin
 
  * git
  * gradle
  * android-emulator
  * ws-cleanup
  * slack
  * embeddable-build-status
  
 ## Build image
 docker build -t jenkins-android-docker .
 
 ## Use image
 docker run --name android-jenkins -p 8080:8080 -p 50000:50000 -v /var/android_jenkins_home:/var/jenkins_home jenkins-android-docker
 
 ## Modification
 From Line 33 ~ 41, you can modify version info using `sdkmanager`. Feel free to change these value.
 
 ## ~License~
 ~Do we really need license?~
