# AWS Key Pair
resource "aws_key_pair" "default" {
  key_name   = "${ var.project["name"] }-${ var.env["zone_d"] }-key-default"
  public_key = ""
}

# EC2
resource "aws_instance" "bastion" {
  ami           = "${ data.aws_ami.ec2.id }"
  instance_type = "${ var.ec2["bastion_type"] }"
  key_name      = "${ aws_key_pair.default.key_name }"
  subnet_id     = "${ var.output_vpc["subnet_public_d"] }"
  private_ip    = "${ var.ec2["bastion_ip"] }"
  user_data     = "${ file("${path.module}/userdata.sh") }"

  iam_instance_profile   = "${ var.output_iam["profile_ec2_bastion_arn"] }"
  vpc_security_group_ids = ["${ var.output_sg["bastion_id"] }"]

  root_block_device = {
    volume_type = "gp2"
    volume_size = "30"
  }

  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_d"] }-ec2-bastion"
  }

  volume_tags {
    Name = "${ var.project["name"] }-${ var.env["zone_d"] }-ebs-bastion"
  }
}

# EIP Association
resource "aws_eip_association" "ec2_bastion_eip" {
  instance_id   = "${ aws_instance.bastion.id }"
  allocation_id = "${ var.eip["bastion_id"] }"
}

