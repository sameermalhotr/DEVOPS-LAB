pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    sudo -H -u user kubectl apply -f kubernetes/deployment.yaml
                    sudo -H -u user kubectl apply -f kubernetes/service.yaml
                    sudo -H -u user kubectl rollout status deployment/devops-lab2
                '''
            }
        }

        stage('Verify') {
            steps {
                sh '''
                    sudo -H -u user kubectl get deployments
                    sudo -H -u user kubectl get pods
                    sudo -H -u user kubectl get services
                '''
            }
        }
    }

    post {
        success {
            echo 'Continuous deployment completed successfully!'
        }
    }
}

