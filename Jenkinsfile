pipeline{
    agent any

    environment{
        DOCKER_IMAGE = "ramazanakdag/demo"
    }

    stages{
        stage('Build'){
            echo "Building..."
            steps{
                sh './mvnw clean package'
            }
        }
        stage('Dockerize'){
            echo "Dockerizing..."
            steps{
                sh 'docker build -t ${DOCKER_IMAGE}'
            }
        }
        stage('Push Docker Image'){
             echo "Pushing image..."
             sh 'docker push ${DOCKER_IMAGE}'
        }
        stage('Deploy'){
            echo "Deploying..."
              sh 'docker run -d -p 8080:8080 ${DOCKER_IMAGE}'
        }

    }
}