output "sg" {
  value = "${
    map(
      "bastion_id", "${ aws_security_group.bastion.id }",
      "alb_id",     "${ aws_security_group.alb.id }",
      "web_id",     "${ aws_security_group.web.id }"
    )
  }"
}

