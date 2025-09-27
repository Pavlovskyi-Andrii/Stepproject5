terraform {
  backend "s3" {
    bucket         = "stepproject5-terraform-state"
    key            = "eks/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}