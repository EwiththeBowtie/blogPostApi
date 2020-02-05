terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "ewiththebowtie"

    workspaces {
      name = "blogPostApi"
    }
  }
}
