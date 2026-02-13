pipeline {
agent any

```
stages {

    stage('Clone Repo') {
        steps {
            git 'https://github.com/2022BCS0205-srideeksha/lab4_bcs205.git'
        }
    }

    stage('Install & Train') {
        steps {
            bat 'pip install -r requirements.txt'
            bat 'python train.py'
        }
    }

    stage('Build Docker Image') {
        steps {
            bat 'docker build -t wine_predict_2022bcs0205 .'
        }
    }

    stage('Run Container') {
        steps {
            bat 'docker stop wine_container || echo no container'
            bat 'docker rm wine_container || echo no container'
            bat 'docker run -d -p 8000:8000 --name wine_container wine_predict_2022bcs0205'
        }
    }
}
```

}
