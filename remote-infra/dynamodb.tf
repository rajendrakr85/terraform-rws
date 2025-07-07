resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "rws-tf-state-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "Locked"

  attribute {
    name = "Locked"
    type = "S"
  }

  tags = {
    Name        = "rws-tf-state-table"
    Environment = "production"
  }
}