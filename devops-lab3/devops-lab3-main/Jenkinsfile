pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Security Tools') {
            steps {
                sh '''
                    python3 -m venv .jenkins-venv
                    .jenkins-venv/bin/pip install bandit pip-audit
                '''
            }
        }

        stage('Bandit Security Scan') {
            steps {
                sh '''
                    .jenkins-venv/bin/bandit -r app monitoring -f txt -o bandit-report.txt || test "$?" -eq 1
                '''
            }
        }

        stage('Dependency Audit') {
            steps {
                sh '''
                    .jenkins-venv/bin/pip-audit -r requirements.txt -f json -o pip-audit-report.json
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'bandit-report.txt,pip-audit-report.json', allowEmptyArchive: true
        }
        success {
            echo 'DevSecOps pipeline completed successfully!'
        }
    }
}
