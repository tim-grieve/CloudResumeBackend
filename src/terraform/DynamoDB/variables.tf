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