resource "aws_dynamodb_table" "demo-table" {
  hash_key = "id"
  name = var.TABLE_NAME
  write_capacity = var.WRITE_CAPACITY
  read_capacity = var.READ_CAPACITY
  attribute {
    name = "id"
    type = "S"
  }

  tags = merge(var.DEFAULT_TAGS, map("Name", var.TABLE_NAME))
}