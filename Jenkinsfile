pipeline{
    agent any

    environment{
        DOCKER_IMAGE = "ramazanakdag/demo"
        DOCKERHUB_CREDENTIALS_ID = 'docker-hub-credentials'
        REGISTRY_URL = 'https://index.docker.io/v1/'
    }

    stages{
        stage('Build'){
            steps{
                echo "Building..."
                sh 'chmod +x ./mvnw'
                sh './mvnw clean package'
            }
        }
        stage('Dockerize'){
            steps{
                echo "Dockerizing..."
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }
        stage('Push Docker Image') {
                    steps {
                        echo "Pushing image..."
                        withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS_ID}", usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
                            sh 'docker login -u $USER -p $PASSWORD ${REGISTRY_URL}'
                            sh "docker push ${DOCKER_IMAGE}"
                        }
                    }
                }
        stage('Deploy'){
            steps{
                 echo "Deploying..."
                 sh 'docker run -d -p 8081:8081 ${DOCKER_IMAGE}'
            }

        }

    }
}