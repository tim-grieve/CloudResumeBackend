resource "aws_dynamodb_table" "visitor-counter" {
    name = var.dynamodb_table_name
    billing_mode = var.dynamodb_table_billingmode
    hash_key = var.dynamodb_table_hashkey

    attribute {
      name = var.dynamodb_table_attribute_name
      type = var.dynamodb_attribute_type
    }

    ttl {
        attribute_name = ""
        enabled = var.dynamodb_table_ttl_attribute_enabled
    }

    tags = {
        "var.dynamodb_table_tag_name" = var.dynamodb_table_tag_value
    }
}

resource "aws_dynamodb_table_item" "initial_entry" {
  table_name = aws_dynamodb_table.visitor-counter.name
  hash_key = aws_dynamodb_table.visitor-counter.hash_key
  item = <<ITEM
  {
    "SiteName": {"S":"${var.dynamodb_initial_value_sitename}"},
    "Count": {"N": "0"}
  }
  ITEM
}