terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.50"
    }
  }

  backend "s3" {
    bucket         = "tokyorust-terraform-state"
    key            = "terraform/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-lock"
    encrypt = true
  }
}

provider "aws" {
  region = "ap-northeast-1"
}
