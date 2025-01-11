terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.83.1"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "4.5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project    = "tf-aws-s3-restic"
      ProjectUrl = "https://github.com/soerenschneider/tf-aws-s3-restic"
    }
  }
}

provider "vault" {
  address = "https://vault.ha.soeren.cloud"
}
