terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-crc-backend"
    key = "terraform.tfstate"
    region = "ca-central-1" 
  }
}

provider "aws" {
  region  = var.provider_region_id
}

module "Dynamodb" {
    source = "./DynamoDB"
    dynamodb_table_name = var.dynamodb_table_name
    dynamodb_table_billingmode = var.dynamodb_table_billingmode
    dynamodb_table_hashkey = var.dynamodb_table_hashkey
    dynamodb_table_attribute_name = var.dynamodb_table_attribute_name
    dynamodb_attribute_type = var.dynamodb_attribute_type
    dynamodb_table_ttl_attribute_name = var.dynamodb_table_ttl_attribute_name
    dynamodb_table_ttl_attribute_enabled = var.dynamodb_table_ttl_attribute_enabled
    dynamodb_table_tag_name = var.dynamodb_table_tag_name
    dynamodb_table_tag_value = var.dynamodb_table_tag_value
    dynamodb_initial_value_sitename = var.dynamodb_initial_value_sitename
}

module "Lambda" {
    source = "./Lambda"
    lambda_function_name = var.lambda_function_name
    lambda_role_permission_sid1 = var.lambda_role_permission_sid1
    lambda_role_permission_sid2 = var.lambda_role_permission_sid2
    lambda_role_permission_sid3 = var.lambda_role_permission_sid3
    lambda_role_permission_type = var.lambda_role_permission_type
    lambda_service_identifier = var.lambda_service_identifier
    lambda_iam_role_name = var.lambda_iam_role_name
    lambda_iam_policy_name = var.lambda_iam_policy_name
    lambda_python_source_file = var.lambda_python_source_file
    lambda_archive_output_path = var.lambda_archive_output_path
    lambda_function_handler_name = var.lambda_function_handler_name
    lambda_runtime_version = var.lambda_runtime_version
    dynamodb_arn = module.Dynamodb.dynamodb_table_arn
}

module "APIGateway" {
    source = "./APIGateway"
    lambda_arn = module.Lambda.lambda_arn
    lambda_function_name = module.Lambda.lambda_function_name
    lambda_invoke_arn = module.Lambda.lambda_invoke_url
    apigateway_name = var.apigateway_name
}

