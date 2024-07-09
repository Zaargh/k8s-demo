terraform {
  backend "s3" {
    bucket = "ja-tfstate-20240702173626741400000001"
    key    = "azure/aks/terraform.tfstate"
    region = "eu-central-1"
    #  dynamodb_table = "ja-tflock"  # I'm working on this project on my own, so it isn't strictly necessary.
    encrypt = true
  }
}
