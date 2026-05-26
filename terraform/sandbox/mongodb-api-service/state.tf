terraform {
  backend "s3" {
    bucket = "synthetic-terraform-state-sandbox"
    key    = "mongodb-api-service/terraform.tfstate"
    region = "us-east-1"
  }
}
