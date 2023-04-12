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