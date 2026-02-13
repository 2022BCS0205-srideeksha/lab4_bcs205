pipeline {
    agent any

    stages {

        stage('Pull Code') {
    steps {
        git branch: 'main',
            url: 'https://github.com/2022BCS0205-srideeksha/lab4_bcs205.git'
    }
}

        stage('Train Model') {
    steps {
        sh '''
        apt-get update
        apt-get install -y python3 python3-pip python3-venv

        # create virtual env
        python3 -m venv venv
        . venv/bin/activate

        pip install --upgrade pip
        pip install -r requirements.txt

        python train.py
        '''
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