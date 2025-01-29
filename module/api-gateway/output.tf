output "api_gateway_fact_execution_arn" {
  value = aws_apigatewayv2_api.fact.execution_arn
}

output "address" {
  value = aws_apigatewayv2_api.fact.api_endpoint
}