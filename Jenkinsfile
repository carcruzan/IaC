properties([
        parameters ([
            string(defaultValue: "dev-test-lambda", description: 'Name Lambda Function', name: 'FunctionName')
        ])
])

node {
    checkout scm
    withAWS(credentials: "aws-dev",region: 'us-east-1'){
        withDockerContainer(args: '-v ${PWD}:/tmp/code -w /tmp/code', image: 'amazon/aws-sam-cli-build-image-provided') {
            stage('Checkout') {
                git(url: 'https://github.com/carcruzan/IaC.git', branch: 'main')
            }
            stage('SAM Deploy'){
                sh '''
                    echo Building...
                    sam build --use-container -t template.yaml
                    cd .aws-sam/build/
                    echo Packaging...
                    sam package --s3-bucket=$S3_BUCKET -t template.yaml --output-template-file=final_template.yaml
                    echo Deplopying...
                    sam deploy -t final_template.yaml --stack-name=test-IaC --region=us-east-1 --capabilities CAPABILITY_IAM --parameter-overrides "ParameterKey=FunctionName,ParameterValue=$FunctionName"
                '''
            }
        }
    }
}