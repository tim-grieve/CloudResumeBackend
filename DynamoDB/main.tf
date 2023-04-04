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

resource "aws_dynamodb_table" "visitor-count" {
    name = "visitor_counter"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "count"

    attribute {
      name = "count"
      type = "N"
    }

    ttl {
        attribute_name = "TimeToExist"
        enabled = false
    }

    tags = {
        Name = "Resume Visitor Counter"
    }
}