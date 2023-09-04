# This file is for Terraform IaC - including a VPC with 2 subnets (public and private), IG, RTs and SG configured accordingly
```JSON
# Step 1: Mention the provider:

provider "aws" {
    # What Region would we like the resource to be created in:
    region = var.region
}

# Step 2: Creating a VPC:
resource "aws_vpc" "florina_HMRC_upskilling_VPC" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags             = {
    Name = "florina_HMRC_upskilling_VPC"
  }
}

# Step 3: Creating a public subnet:
resource "aws_subnet" "florina_HMRC_public_subnet" {
    vpc_id                  = var.vpc_id
    cidr_block              = var.public_subnet_cidr
    map_public_ip_on_launch = true
    tags                    = {
        Name = "florina_HMRC_public_subnet"
    }
}

# Step 3: Create security group for the instance that will be created in the public subnet:
resource "aws_security_group" "florina_HMRC_SG_public" {
    name = "open-ports-22-and-80"
    description = "florina_HMRC_allow_ports_22_and_80"
    vpc_id = var.vpc_id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.my_ip]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "florina-HMRC-SG-public"
    }
}

# Step 4: Create internet gateway (to allow internet access to the public subnet):
resource "aws_internet_gateway" "florina-HMRC-IG" {
    vpc_id = var.vpc_id
    tags   = {
        Name = "florina-hmrc-upskilling-IG"
    }
}

# Step 5: Create Route Table to connect public subnet to IG:
resource "aws_route_table" "florina_HMRC_upskilling_public_RT" {
    vpc_id = var.vpc_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = var.ig_id
    }
    tags  = {
        Name = "florina_HMRC_upskilling_public_RT"
    }
}

# Step 5.1.: Associate the Public RT to the Public Subnet:
resource "aws_route_table_association" "florina_HMRC_public_RT_association" {
    subnet_id      = var.public_subnet
    route_table_id = var.public_subnet_RT
}

# Step 6: Create private subnet:
resource "aws_subnet" "florina_HMRC_private_subnet" {
    vpc_id                  = var.vpc_id
    cidr_block              = var.private_subnet_cidr
    tags                    = {
        Name = "florina_HMRC_private_subnet"
    }
}

# Step 7: Create security group for the instance that will be created in the private subnet:
resource "aws_security_group" "florina_HMRC_SG_private" {
    name = "open-ports-22"
    description = "florina_HMRC_allow_ports_22"
    vpc_id = var.vpc_id

    ingress {
        from_port   = "22"
        to_port     = "22"
        protocol    = "tcp"
        cidr_blocks = [var.my_ip]
    }

    tags = {
        Name = "florina-HMRC-SG-private"
    }
}

# As for the Private subnet there has been no RT directly associated, it will be associated by default with the default RT that allows local access across the VPC.

```