![Codebuild Build Badge]
(https://codebuild.us-west-2.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiMG1UajdLL0JIVUNiMkZNOUNkZU15UDJURFNqRjczcW1EcFQ1clJDbjIwUTdheGY1dTJ1NjdTOEVObzF0eWN0eTFTNFc0aWtpZ2RyUkFwKzZRT3ZpSVdNPSIsIml2UGFyYW1ldGVyU3BlYyI6IjhEZGM2MXhaSjVXbEFKdDQiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=master)
# Blog Post Api

## Description

A simple api for creating blog posts and listing blog previously created blog posts using Node, Express, and Sqlite3.

## Getting Started

### What You'll Need

- Docker

### Install Node Modules

With `blogPostApi/` as your current directory run:

```bash
docker-compose run api npm install
```

### Run locally

```bash
docker-compose up
```

The server should be running at http://localhost:3000/posts

### Run tests locally

```bash
docker-compose run api npm test
```
