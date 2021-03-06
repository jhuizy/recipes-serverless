variable "github_oauth_token" {}
variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "ap-southeast-2"
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "recipes-serverless-tfstate"
    key    = "tfstate"
    region = "ap-southeast-2"
  }
}


module "github_ci" {
  source  = "github.com/squidfunk/terraform-aws-github-ci"
  version = "0.5.2"

  namespace          = "recipes"
  github_owner       = "jhuizy"
  github_repository  = "recipes-serverless"
  github_oauth_token = "${var.github_oauth_token}"
  codebuild_bucket = "recipes-ci-artifacts"
  codebuild_image  = "aws/codebuild/nodejs:8.11.0"
}