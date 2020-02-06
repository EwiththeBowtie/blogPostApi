terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "ewiththebowtie"

    workspaces {
      name = "blogPostApi"
    }
  }
}

provider "aws" {
  version = "~> 2.0"
  region  = "us-west-2"
}
