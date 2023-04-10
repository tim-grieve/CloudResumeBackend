terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
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
}

module "APIGateway" {
    source = "./APIGateway"
    lambda_arn = module.Lambda.lambda_arn
    lambda_function_name = module.Lambda.lambda_function_name
}

