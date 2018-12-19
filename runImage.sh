mkdir /data/jenkins-android-docker
sudo chown -R 1000:1000 /data/jenkins-android-docker
sudo docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v /data/jenkins-android-docker:/var/jenkins_home windsekirun/jenkins-android-docker:1.0.2
