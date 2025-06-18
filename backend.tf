terraform {
  backend "s3" {
    bucket       = "uc-12-rds-aurora"
    key          = "terraform.tfstate"
    region       = "us-west-1"
    
  }
}