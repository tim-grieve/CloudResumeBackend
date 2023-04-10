resource "aws_apigatewayv2_api" "counter_api" {
  name = "resume-counter-api"
  protocol_type = "HTTP"
  target = var.lambda_arn
  route_key = "ANY /${var.lambda_function_name}"
  #target = aws_lambda_function.ResumeSiteCounter.arn
  #route_key = "ANY /${aws_lambda_function.ResumeSiteCounter.function_name}"
}

resource "aws_lambda_permission" "apigateway_permissions" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal = "apigateway.amazonaws.com"
}