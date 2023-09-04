# This file is for Terraform IaC support-configuration

# Step 1: Mention the provider:
provider "aws" {
    # What Region would we like the resource to be created in:
    region = var.region
}

# Step 2:Create env variable holding the values of your AWS access and secret access keys. Make sure to close the current terminal/vscode after completing and reopen.

# Step 3: Create a resource in AWS:
resource "aws_instance" "florina-hmrc-first-vm" {
    # which os to use - AMI ID
    ami = var.ec2_ami
    # Linux ubuntu 18.04Lts

    #type of instance
    instance_type = "t2.micro"

    # tags to specify owner
    tags = {
        Name = "florina_hmrc_upskilling"
    }
}



