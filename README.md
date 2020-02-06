![Codebuild Build Badge](https://codebuild.us-west-2.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiMG1UajdLL0JIVUNiMkZNOUNkZU15UDJURFNqRjczcW1EcFQ1clJDbjIwUTdheGY1dTJ1NjdTOEVObzF0eWN0eTFTNFc0aWtpZ2RyUkFwKzZRT3ZpSVdNPSIsIml2UGFyYW1ldGVyU3BlYyI6IjhEZGM2MXhaSjVXbEFKdDQiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=master)

# Blog Post Api

## Description

A simple api for creating blog posts and listing blog previously created blog posts using Node, Express, and Sqlite3.

## Getting Started

### Running Locally with Docker

#### Install Node Modules

With `blogPostApi/` as your current directory run:

```bash
docker-compose run api npm install
```

#### Start the API

```bash
docker-compose up
```

The server should be running at http://localhost:3000/posts

#### Run tests

```bash
docker-compose run api npm test
```

## The CI Pipeline

### Terraform Cloud

Inside the `terraform` folder you'll find several .tf files. These files define the CI Pipeline for the api.

![Terraform Cloud](TerraformCloud.png?raw=true)

#### Updating the build pipeline

When a commit on a file in the terraform folder of the master branch is pushed Terraform Cloud will trigger a plan and (if successful) apply the infrastructure changes defined in the .tf files.

### AWS CodeBuild

Inside the `api` folder you'll find a `buildspec.yml` file.

It defines the following pipeline:

    Build Dockerfile

    -> Tag the image with the last 7 characters of the commit hash

    -> Tag the image as "latest"

    -> Run the test script on the image

    -> If all tests pass, push the image to the AWS Elastic Container Repository (ECR)

### Deploying the latest revision

#### Deploying on an EC2 Instance using Docker

##### Requirements

- The AMI must have docker and the aws cli (atleast version 2) installed
- The instance profile of the EC2 profile must have permission to pull from the ECR repository

##### Caution! Ephemeral Database

Sqlite3 runs inside the docker container. When deploying or restarting the application all entries will be lost.

#### Pull the latest image and run the api

```bash
docker pull 021204337871.dkr.ecr.us-west-2.amazonaws.com/blog-post-api:latest
docker run -p 3000:3000 021204337871.dkr.ecr.us-west-2.amazonaws.com/blog-post-api:latest
```

The application should now be running on PORT 3000. This could be exposed through an Application Load Balancer or pubic ip address.

# Next Steps

The following would be reasonable next steps for improving the deployment process of the api.

- Automate deployment through a CD tool such as AWS CodeDeploy or Hashicorp Nomad via Terraform and Packer (for building the AMIs)
- Switch database to a managed relational database such as Postgres on AWS Aurora for persistence
- Deploy with a container orchastration tool such as Kubernetes or ECS
