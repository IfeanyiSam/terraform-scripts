terraform {
  backend "s3" {
    bucket = "terra-state-dev1"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}