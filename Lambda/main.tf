data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = var.lambda_role_permission_type
      identifiers = [var.lambda_service_identifier]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "role_policy" {
  statement {
    effect = "Allow"
    
    sid = var.lambda_role_permission_sid1

    actions = [
      "dynamodb:GetItem",
      "dynamodb:UpdateItem",
    ]

    resources = [
      "${var.dynamodb_arn}:table/*",
    ]
  }
  
  statement {
    effect = "Allow"

    sid = var.lambda_role_permission_sid2

    actions = [
      "dynamodb:Query",
    ]

    resources = [
      "${var.dynamodb_arn}:table/*/index/*",
    ]
  }

  statement {
    effect = "Allow"

    sid = var.lambda_role_permission_sid3

    actions = [
      "dynamodb:ListTables"
    ]

    resources = [
      "*"
    ]
  }  
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = var.lambda_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "policy" {
  name = var.lambda_iam_policy_name
  role = aws_iam_role.iam_for_lambda.id

  policy = data.aws_iam_policy_document.role_policy.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = var.lambda_python_source_file
  output_path = var.lambda_archive_output_path
}

resource "aws_lambda_function" "ResumeSiteCounter" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = var.lambda_archive_output_path
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler = var.lambda_function_handler_name
  
  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = var.lambda_runtime_version
}

