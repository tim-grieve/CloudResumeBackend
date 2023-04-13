resource "aws_apigatewayv2_api" "counter_api" {
  name = "resume-counter-api"
  protocol_type = "HTTP"
  target = var.lambda_arn
  route_key = "ANY /${var.lambda_function_name}"
  
  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["POST","GET","OPTIONS"]
    allow_headers = ["Content-Type"]
    
    max_age = 300
  }
}

resource "aws_lambda_permission" "apigateway_permissions" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal = "apigateway.amazonaws.com"
}

resource "aws_apigatewayv2_integration" "options_lambda" {
  api_id = aws_apigatewayv2_api.counter_api.id
  integration_type = "AWS_PROXY"

  connection_type           = "INTERNET"
  description               = "Lambda OPTIONS"
  integration_method        = "OPTIONS"
  integration_uri           = var.lambda_invoke_arn
  passthrough_behavior      = "WHEN_NO_MATCH"
  
}
resource "aws_apigatewayv2_route" "options" {
  api_id = aws_apigatewayv2_api.counter_api.id
  route_key = "OPTIONS /{proxy+}"

  target = "integrations/${aws_apigatewayv2_integration.options_lambda.id}"
}