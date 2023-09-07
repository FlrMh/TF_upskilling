resource "aws_instance" "florina-hmrc-first-vm" {
    # which os to use - AMI ID
    ami = var.ec2_ami
    # Linux ubuntu 18.04Lts

    #type of instance
    instance_type = var.ec2_instance_type
}
