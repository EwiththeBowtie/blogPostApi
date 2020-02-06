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

  service_role = aws_iam_role.codebuild.arn

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
		buildspec = "./api/buildspec.yml"
  }
}

resource "aws_iam_role_policy_attachment" "codebuild" {
  role       = aws_iam_role.codebuild.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy_attachment" "codebuild_logs" {
  role       = aws_iam_role.codebuild.name
  policy_arn = "arn:aws:iam::021204337871:policy/CodeBuildCloudWatchLogs"
}

variable "github_access_token" {
  type        = string
  description = "The access token codebuild uses for webhooks and git clone"
}

resource "aws_codebuild_source_credential" "blogPostApi" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = var.github_access_token
}

resource "aws_codebuild_webhook" "blogPostApi" {
  project_name = aws_codebuild_project.project.name

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }

    filter {
      type    = "HEAD_REF"
      pattern = "master"
    }
  }
}

resource "aws_ecr_repository" "blogPostApi" {
  name                 = "blog-post-api"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
