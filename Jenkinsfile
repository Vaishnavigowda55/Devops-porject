pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-python-app"
        AWS_REGION = "ap-south-1"
        ECR_REPO = "123456789012.dkr.ecr.ap-south-1.amazonaws.com/my-python-app"
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Vaishnavigowda55/Devops-porject.git', branch: 'main'
            }
        }

        stage('Login to AWS ECR') {
            steps {
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'AWS_SECRET_KEY', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh '''
                        aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                        aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                        aws configure set default.region ap-south-1
                        aws ecr get-login-password | docker login --username AWS --password-stdin $ECR_REPO
                    '''
                }
            }
        }

        stage('Build and Push') {
            steps {
                sh """
                    docker build -t $IMAGE_NAME:$BUILD_ID .
                    docker tag $IMAGE_NAME:$BUILD_ID $ECR_REPO:$BUILD_ID
                    docker push $ECR_REPO:$BUILD_ID
                """
            }
        }
    }
}
