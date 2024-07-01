# terraform {
#   backend "s3" {
#     bucket         = "<ENTER-YOUR-BUCKET-NAME-HERE>"
#     key            = "aws/tf_backend/terraform.tfstate"
#     region         = "eu-central-1"
#   #  dynamodb_table = "ja-tflock"  # I'm working on this project on my own, so it isn't strictly necessary.
#     encrypt        = true
#   }
# }