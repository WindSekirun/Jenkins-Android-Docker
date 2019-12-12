@Library('jenkins-shared-library')_
pipeline {
    environment {
        registry = "windsekirun/jenkins-android-docker"
        registryCredential = 'DockerHub'
    }
    agent any
    stages {
        stage ('Start') {
            steps {
                sendNotifications 'STARTED'
            }
        }
        stage('Environment') {
            parallel {
                stage('display') {
                    steps {
                        sh 'ls -la'
                    }
                }
            }
        }
        stage('Build docker image') {
            steps {
                sh 'docker build -t $registry:$(cat VERSION) --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` --build-arg VCS_REF=`git rev-parse --short HEAD` --build-arg VERSION=`cat VERSION` .'
            }
        }
        stage('Deploy docker image') {
            steps {
                withDockerRegistry([ credentialsId: registryCredential, url: "" ]) {
                    sh 'docker push $registry:latest'
                }
            }
        }
        stage('Clean docker image') {
            steps{
                script {
                    try {
                        sh "docker rmi $registry"
                    } catch (Exception e) {
                        echo err.getMessage()
                    }
                }
            }
        }
     }
    post {
        always {
            sendNotifications currentBuild.result
        }
    }
}
