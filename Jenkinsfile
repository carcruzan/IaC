pipeline {
    agent {
        docker { image 'amazon/aws-sam-cli-build-image-provided' }
    }

	parameters {
    	string(defaultValue: "dev-lambda", description: 'Name Lambda Function', name: 'FunctionName')
	}

	stages {
        stage('Checkout') {
            steps {
                git(url: 'https://github.com/carcruzan/IaC.git', branch: 'main')
            }            
        }
        stage('SAM Deploy'){
            steps {
                sh '''
                    ls -la
                    echo Building...
                    sam build
                    echo Packaging...
                    sam package --s3-bucket=iac-training-ecs -t template.yaml --region=us-east-1 --output-template-file=final_template.yaml
                    echo Deplopying...
                    sam deploy -t final_template.yaml --stack-name=test-IaC --region=us-east-1 --no-fail-on-empty-changeset --capabilities CAPABILITY_IAM --parameter-overrides "ParameterKey=FunctionName,ParameterValue=$FunctionName"
                '''
            }
        }
	}
}
