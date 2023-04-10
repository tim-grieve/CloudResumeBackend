output "lambda_arn" {
  value = aws_lambda_function.ResumeSiteCounter.arn
}

output "lambda_function_name" {
  value = aws_lambda_function.ResumeSiteCounter.function_name
}