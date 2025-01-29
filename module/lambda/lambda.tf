data "archive_file" "fact" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/upload/lambda.zip"
}

resource "aws_lambda_function" "fact" {
  filename      = data.archive_file.fact.output_path
  function_name = "factLambda"
  role          = aws_iam_role.lambda_fact.arn
  handler       = "main.lambda_handler"

  source_code_hash = data.archive_file.fact.output_base64sha256

  runtime = "python3.10"


  environment {
    variables = {
      fact_ENV = "fact_VALUE"
    }
  }

  timeout                        = 29
  # reserved_concurrent_executions = 5
  publish                        = true
}

resource "aws_lambda_permission" "fact" {
  statement_id  = "AllowAPIGatewayfact"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.fact.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_gateway_fact_execution_arn}/*/*"
}
