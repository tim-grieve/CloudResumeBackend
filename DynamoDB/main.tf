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

resource "aws_dynamodb_table" "visitor-counter" {
    name = "visitor_counter"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "SiteName"

    attribute {
      name = "SiteName"
      type = "S"
    }

    ttl {
        attribute_name = "TimeToExist"
        enabled = false
    }

    tags = {
        Name = "Resume Visitor Counter"
    }
}

resource "aws_dynamodb_table_item" "initial_entry" {
  table_name = aws_dynamodb_table.visitor-counter.name
  hash_key = aws_dynamodb_table.visitor-counter.hash_key
  item = <<ITEM
  {
    "SiteName": {"S": "Resume"},
    "Count": {"N": "0"}
  }
  ITEM
}