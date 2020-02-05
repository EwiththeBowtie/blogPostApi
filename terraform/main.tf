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

resource "aws_iam_role" "codebuild" {
  name = "codebuildServiceRole"

  assume_role_policy = <<EOF
			{
				  "Version": "2012-10-17",
					  "Statement": [
							    {
  						      "Effect": "Allow",
							      "Principal": {
   						        "Service": "codebuild.amazonaws.com"
							      },
							      "Action": "sts:AssumeRole"
							    }
					  ]
			}
EOF
}

resource "aws_codebuild_project" "project" {
  name           = "blogPostApi"
  description    = "blogPostApiBuild"
  build_timeout  = "5"
  queued_timeout = "5"

  service_role = "${aws_iam_role.codebuild.arn}"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:2.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "SOME_KEY1"
      value = "SOME_VALUE1"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/EwiththeBowtie/blogPostApi.git"
    git_clone_depth = 1
  }

}
