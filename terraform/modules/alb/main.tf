resource "aws_lb" "web" {
  name = "${ var.project["name"] }-${ var.env["zone_d"] }-alb-web"
  internal = false
  load_balancer_type = "application"
  security_groups    = ["${ var.output_sg["alb_id"] }"]
  subnets            = [
    "${ var.output_vpc["subnet_front_a"] }",
    "${ var.output_vpc["subnet_front_c"] }",
    "${ var.output_vpc["subnet_front_d"] }"
  ]

  enable_deletion_protection = true

  tags = {
    Name = "${ var.project["name"] }-${ var.env["zone_d"] }-alb-web"
  }
}

