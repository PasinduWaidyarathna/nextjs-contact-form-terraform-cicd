terraform {

  required_version = ">=0.13.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 2.7.0"
      }
  }
  backend "s3" {
    bucket         = "pasindumw-terraform-gh" // S3 bucket name for storing the state file
    region         = "eu-north-1"
    key            = "nextjs-contact-form/terraform.tfstate"
    encrypt = true
  }

}