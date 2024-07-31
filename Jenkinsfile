pipeline{
    agent any

    environment{
        DOCKER_IMAGE = "ramazanakdag/demo"
    }

    stages{
        stage('Build'){
            steps{
                echo "Building..."
                sh './mvnw clean package'
            }
        }
        stage('Dockerize'){
            steps{
                echo "Dockerizing..."
                sh 'docker build -t ${DOCKER_IMAGE}'
            }
        }
        stage('Push Docker Image'){
            steps{
                echo "Pushing image..."
                sh 'docker push ${DOCKER_IMAGE}'
            }

        }
        stage('Deploy'){
            steps{
                 echo "Deploying..."
                 sh 'docker run -d -p 8080:8080 ${DOCKER_IMAGE}'
            }

        }

    }
}