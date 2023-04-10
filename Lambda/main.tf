data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "role_policy" {
  statement {
    effect = "Allow"
    
    sid = "VisualEditor0"

    actions = [
      "dynamodb:GetItem",
      "dynamodb:UpdateItem",
    ]

    resources = [
      "arn:aws:dynamodb:*:053127563287:table/*",
    ]
  }
  
  statement {
    effect = "Allow"

    sid = "VisualEditor1"

    actions = [
      "dynamodb:Query",
    ]

    resources = [
      "arn:aws:dynamodb:*:053127563287:table/*/index/*",
    ]
  }

  statement {
    effect = "Allow"

    sid = "VisualEditor2"

    actions = [
      "dynamodb:ListTables"
    ]

    resources = [
      "*"
    ]
  }  
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "policy" {
  name = "resume_lambda_policy"
  role = aws_iam_role.iam_for_lambda.id

  policy = data.aws_iam_policy_document.role_policy.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "./Lambda/lambdafunction.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "ResumeSiteCounter" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler = "lambdafunction.lambda_handler"
  
  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.9"
}

