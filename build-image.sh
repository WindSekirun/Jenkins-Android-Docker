docker build -t jenkins-android-docker:1.0.1 .
docker tag jenkins-android-docker:1.0.1 windsekirun/jenkins-android-docker:1.0.1
docker push windsekirun/jenkins-android-docker:1.0.1
