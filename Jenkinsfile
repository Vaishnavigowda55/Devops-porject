pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = '24220128995'// with your AWS Account ID
        AWS_REGION = 'ap-easr-1'   // Replace with your AWS region
        ECR_REPOSITORY = 'my-python-app' // Replace with your ECR repository name
        IMAGE_NAME = 'my-docker-image'              // Replace with your Docker image name
    }

    stages {
        stage('Checkout') {
            steps {
                // Pull code from GitHub
                git branch: 'main', url: 'https://github.com/Vaishnavigowda55/Devops-project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker Image...'
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Login to AWS ECR') {
            steps {
                script {
                    // Log in to ECR
                    sh '''
                    aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                    '''
                }
            }
        }

        stage('Tag Docker Image') {
            steps {
                script {
                    // Tag the image with ECR repository URI
                    sh 'docker tag $IMAGE_NAME:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:latest'
                }
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                script {
                    // Push the tagged image to ECR
                    sh 'docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:latest'
                }
            }
        }
    }

    post {
        success {
            echo 'Docker image pushed to AWS ECR successfully!'
        }
        failure {
            echo 'Something went wrong with pushing the Docker image to ECR.'
        }
    }
}
