pipeline{
    agent any

    environment{
        DOCKER_IMAGE = "ramazanakdag/demo"
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
        stage('Push Docker Image'){
            steps{
                echo "Pushing image..."
                withCredentials([usernamePassword( credentialsId: 'docker-hub-credentials', usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
                        def registry_url = "registry.hub.docker.com/"
                        sh "docker login -u $USER -p $PASSWORD ${registry_url}"
                        docker.withRegistry("http://${registry_url}", "docker-hub-credentials") {
                            sh "docker push ${DOCKER_IMAGE}"
                        }
                    }
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