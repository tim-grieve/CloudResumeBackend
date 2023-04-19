variable "provider_region_id" {
    type = string
    default = "ca-central-1"
}

variable "lambda_function_name" {
    type = string
}

variable "lambda_role_permission_sid1" {
    type = string
}

variable "lambda_role_permission_sid2" {
    type = string
}

variable "lambda_role_permission_sid3" {
    type = string
}

variable "lambda_role_permission_type" {
    type = string
}

variable "lambda_service_identifier" {
  type = string
}

variable "lambda_iam_role_name" {
  type = string
}

variable "lambda_iam_policy_name" {
  type = string  
}

variable "lambda_python_source_file" {
    type = string
}

variable "lambda_archive_output_path" {
    type = string
}

variable "lambda_function_handler_name" {
    type = string
}

variable "lambda_runtime_version" {
    type = string
}

variable "dynamodb_table_name" {
  type = string
}

variable "dynamodb_table_billingmode" {
  type = string
}

variable "dynamodb_table_hashkey" {
  type = string
}

variable "dynamodb_table_attribute_name" {
  type = string  
}

variable "dynamodb_table_ttl_attribute_name" {
  type = string
}

variable "dynamodb_table_ttl_attribute_enabled" {
  type = bool
}

variable "dynamodb_attribute_type" {
  type =  string
}

variable "dynamodb_table_tag_name" {
  type = string
}

variable "dynamodb_table_tag_value" {
  type = string
}

variable "dynamodb_initial_value_sitename" {
  type = string
}

variable "apigateway_name" {
  type = string
}
