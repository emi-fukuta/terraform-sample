data "aws_ami" "ec2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name      = "name"
    values    = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }
}

