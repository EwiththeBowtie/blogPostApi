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

#### Updating the build pipeline

When a commit on a file in the terraform folder of the master branch is pushed Terraform Cloud will trigger a plan and (if successful) apply the infrastructure changes defined in the .tf files.

### AWS CodeBuild
Inside the `api` folder you'll find a `buildspec.yml` file.

It defines the following pipeline:
Build Dockerfile -> Tag the image with the last 7 characters of the commit hash -> Tag the image as "latest" -> Run the test script on the image -> If all tests pass, push the image to the AWS Elastic Container Repository (ECR) 
