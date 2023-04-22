output "lambda_arn" {
  value = aws_lambda_function.ResumeSiteCounter.arn
}

output "lambda_function_name" {
  value = aws_lambda_function.ResumeSiteCounter.function_name
}

output "lambda_invoke_url" {
  value = aws_lambda_function.ResumeSiteCounter.invoke_arn
}