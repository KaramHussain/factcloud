resource "aws_apigatewayv2_api" "fact" {
  name          = "factAPI"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "fact_routes" {
  api_id                 = aws_apigatewayv2_api.fact.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.lambda_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "fact_route" {
  api_id    = aws_apigatewayv2_api.fact.id
  route_key = "GET /fact"
  target    = "integrations/${aws_apigatewayv2_integration.fact_routes.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.fact.id
  name        = "$default"
  auto_deploy = true
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway_fact.arn
    format          = jsonencode({ "requestId" : "$context.requestId", "ip" : "$context.identity.sourceIp", "requestTime" : "$context.requestTime", "httpMethod" : "$context.httpMethod", "routeKey" : "$context.routeKey", "status" : "$context.status", "protocol" : "$context.protocol", "responseLength" : "$context.responseLength" })
  }
}

resource "aws_cloudwatch_log_group" "api_gateway_fact" {
  name              = "/aws/apigateway/factAPI"
  retention_in_days = 7
}

