data "archive_file" "demo_lambda_zip" {
  type        = "zip"
  source_dir  = "test-function"
  output_path = "test-function.zip"
}

resource "aws_iam_role" "demo_lambda" {
  name = "role_demo_lambda"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_lambda_function" "demo_lambda" {
  filename         = data.archive_file.demo_lambda_zip.output_path
  source_code_hash = data.archive_file.demo_lambda_zip.output_base64sha256
  role             = aws_iam_role.demo_lambda.arn
  function_name    = "demo_lambda"
  handler          = "handler.lambda_handler"
  runtime          = "python3.8"
}
