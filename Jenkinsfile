pipeline {
    agent any

    stages {
        stage('Deploy') {
            steps {
                script {
                    sh '''
                        terraform init
                        terraform plan
                        terraform apply -auto-approve
                    
                    '''
                }
            }
        }
    }
}
