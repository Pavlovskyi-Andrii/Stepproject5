terraform {
  backend "s3" {
    bucket         = "stepproject5-terraform-state-7fa3608df9c57d28"
    key            = "eks/terraform.tfstate"
    region         = "eu-central-1"
    use_lockfile   = true
    encrypt        = true
  }
}
