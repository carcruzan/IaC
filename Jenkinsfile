pipeline {
    agent {
        docker { image 'amazon/aws-sam-cli-build-image-provided' }
    }

	parameters {
    	string(defaultValue: "dev-test-lambda", description: 'Name Lambda Function', name: 'FunctionName')
	}

	stages {
        stage('Checkout') {
            steps {
                git(url: 'https://github.com/carcruzan/IaC.git', branch: 'main')
            }
            
        }
        stage('SAM Deploy'){
            steps {
                withAWS(credentials: 'aws-credentials', region: 'us-east-1') {
                    sh '''
                        ls -la
                        aws sts assume-role --role-arn arn:aws:iam::184161772257:role/DevOps-test --role-session-name s3-access-example
                        echo Building...
                        sam build
                        echo Packaging...
                        sam package --s3-bucket=iac-training-ecs -t template.yaml --output-template-file=final_template.yaml
                        echo Deplopying...
                        sam deploy -t final_template.yaml --stack-name=test-IaC --region=us-east-1 --capabilities CAPABILITY_IAM --parameter-overrides "ParameterKey=FunctionName,ParameterValue=$FunctionName"
                    '''
                }
            }
        }
	}
}
