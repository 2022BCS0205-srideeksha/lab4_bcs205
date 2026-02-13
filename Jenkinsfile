pipeline {
    agent any

    stages {

        stage('Pull Code') {
            steps {
                git 'https://github.com/2022BCS0205-srideeksha/lab4_bcs205.git'
            }
        }

        stage('Train Model') {
            steps {
                sh 'python train.py'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t srideekshaa/wine_predict_2022bcs0205:latest .'
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker run -d -p 8001:8000 srideekshaa/wine_predict_2022bcs0205:latest'
            }
        }
    }
}