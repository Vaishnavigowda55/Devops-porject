pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Vaishnavigowda55/Devops-porject.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building for the Docker Image...'
                sh 'docker build -t my-python-app .'
            }
        }

        stage('Run') {
            steps {
                echo 'Running the Docker container...'
                sh 'docker run -d -p 5000:5000 my-python-app'
            }
        }
    }
}
