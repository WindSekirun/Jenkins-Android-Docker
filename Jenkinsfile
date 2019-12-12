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
                sh 'docker build -t $registry:latest --build-arg VCS_REF=`git rev-parse --short HEAD` .'
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
