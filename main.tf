# This file is for Terraform IaC support-configuration
# Step 1: Mention the provider:
provider "aws" {
    # What Region would we like the resource to be created in:
   region = var.region
}

# Step 2:Create env variable holding the values of your AWS access and secret access keys. Make sure to close the current terminal/vscode after completing and reopen.

# Step 3: Create a resource in AWS:
module "ec2-module" {
    source = "./modules/ec2-module"
}



# Set up GitHub provider

provider "github" {
    token = var.github_token
}

module "github-module" {
    source = "./modules/github-module"
}
