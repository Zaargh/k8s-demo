resource "aws_dynamodb_table" "terraform_locks" {
  count = 0 # I'm working on this project on my own, so it isn't strictly necessary.

  name         = "ja-tflock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}