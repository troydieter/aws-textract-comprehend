provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

data "aws_caller_identity" "current" {}

resource "random_id" "rando" {
  byte_length = 2
}