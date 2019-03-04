# Security Group

resource "aws_security_group" "bastion" {
  name        = "${ var.project["name"] }-${ var.env["zone_d"] }-sg-ec2-bastion"
  description = "for bastion servers"
  vpc_id      = "${ var.output_vpc["vpc_id"] }"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${ var.office_ips }"]
  }

  ingress {
    from_port   = 12321
    to_port     = 12321
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${ var.vpc["cidr_vpc"] }"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_d"] }-sg-ec2-bastion"
  }
}

resource "aws_security_group" "alb" {
  name        = "${ var.project["name"] }-${ var.env["zone_d"] }-sg-alb-web"
  description = "for web albs"
  vpc_id      = "${ var.output_vpc["vpc_id"] }"
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_d"] }-sg-alb-web"
  }
}

resource "aws_security_group" "web" {
  name        = "${ var.project["name"] }-${ var.env["zone_d"] }-sg-ec2-web"
  description = "for web servers"
  vpc_id      = "${ var.output_vpc["vpc_id"] }"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    self            = true
    security_groups = ["${ aws_security_group.bastion.id }"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    self            = true
    security_groups = ["${ aws_security_group.alb.id }"]
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    self            = true
  }

  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    self            = true
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    self            = true
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    self            = true
  }

  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_d"] }-sg-ec2-web"
  }
}

resource "aws_security_group_rule" "alb_to_web" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${ aws_security_group.web.id }"
  
  security_group_id = "${ aws_security_group.alb.id }" 
}

