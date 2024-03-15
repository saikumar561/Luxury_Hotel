pipeline {
    agent {
        label 'ubuntu'
    }
    environment {
        DOCKER_REGISTRY_URL = "https://index.docker.io/v1/" // Docker Hub registry URL
        DOCKER_IMAGE_NAME = "nsku537/luxury:${BUILD_NUMBER}" // Include the Docker Hub username in the image name
    }
    stages {
        stage('Git Checkout') {
            steps {
                git credentialsId: 'git', url: 'https://github.com/saikumar561/Luxury_Hotel.git'
            }
        }
        stage('Docker-image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')])
                {
                    script {
                        sh "docker build -t ${DOCKER_IMAGE_NAME} ."
                        sh "echo ${DOCKER_HUB_PASSWORD} | docker login -u ${DOCKER_HUB_USERNAME} --password-stdin ${DOCKER_REGISTRY_URL}"
                        sh "docker push ${DOCKER_IMAGE_NAME}"
                    }
                }
            }
        }
        stage('Update Deployment File') {
        environment {
            GIT_REPO_NAME = "Luxury_Hotel"
            GIT_USER_NAME = "saikumar561"
        }
        steps {
            withCredentials([usernamePassword(credentialsId: 'git', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {
              dir("${WORKSPACE}") {
              script{
                  sh 'echo ${WORKSPACE}'
                 sh 'pwd'
                  sh 'ls -al'
                sh '''
                    git init
                    git config --global --add safe.directory /home/ubuntu/jenkins-slave/workspace/first
                    BUILD_NUMBER=${BUILD_NUMBER}
                    sed -i "s/replaceImageTag/${BUILD_NUMBER}/g" Manifest/luxury.yaml
                    git add Manifest/luxury.yaml
                    git config user.email "ksai92839@gmail.com"
                    git config user.name "saikumar561"
                    git commit -m "Update deployment image to version ${BUILD_NUMBER}"
                    git push https://${GIT_PASSWORD}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} master
                '''
            }
            }
        }
        }
    
            
        }
    }
        
}