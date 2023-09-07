# Set up GitHub provider

provider "github" {
    token = var.github_token
}

resource "github_repository" "example-git-repo-tf" {
    name        = "example-repo-tf"
    description = "repo created with tf"
    visibility  = "public"
}

