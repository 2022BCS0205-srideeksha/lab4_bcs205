pipeline {
    agent any

    environment {
        IMAGE_NAME = "srideekshaa/wine_predict_2022bcs0205:latest"
        CONTAINER_NAME = "wine-api-test"
        PORT = "8000"
    }

    stages {

        stage('Stage 1: Pull Image') {
            steps {
                sh '''
                docker pull $IMAGE_NAME
                '''
            }
        }

        stage('Stage 2: Run Container') {
            steps {
                sh '''
                docker run -d -p 8000:8000 --name $CONTAINER_NAME $IMAGE_NAME
                '''
            }
        }

        stage('Stage 3: Wait for Service Readiness') {
            steps {
                sh '''
                sleep 10
                '''
            }
        }

        stage('Stage 4: Valid Inference Test') {
            steps {
                sh '''
                STATUS=$(curl -s -o response.json -w "%{http_code}" \
                -X POST http://host.docker.internal:8000/predict \
                -H "Content-Type: application/json" \
                -d @valid.json)

                cat response.json

                if [ "$STATUS" -ne 200 ]; then
                    exit 1
                fi

                grep predicted_quality response.json || exit 1
                '''
            }
        }

        stage('Stage 5: Invalid Inference Test') {
            steps {
                sh '''
                STATUS=$(curl -s -o invalid_response.json -w "%{http_code}" \
                -X POST http://host.docker.internal:8000/predict \
                -H "Content-Type: application/json" \
                -d @invalid.json)

                cat invalid_response.json

                if [ "$STATUS" -eq 200 ]; then
                    exit 1
                fi
                '''
            }
        }

        stage('Stage 6: Stop Container') {
            steps {
                sh '''
                docker stop $CONTAINER_NAME
                docker rm $CONTAINER_NAME
                '''
            }
        }
    }

    post {
        always {
            sh 'docker stop $CONTAINER_NAME || true'
            sh 'docker rm $CONTAINER_NAME || true'
        }
    }
}