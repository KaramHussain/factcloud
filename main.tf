module "api_gateway" {
  source     = "./module/api-gateway"
  lambda_arn = module.lambda.lambda_arn
}

module "lambda" {
  source                           = "./module/lambda"
  api_gateway_fact_execution_arn = module.api_gateway.api_gateway_fact_execution_arn
}

output "api_gateway_url" {
  value = module.api_gateway.address
}