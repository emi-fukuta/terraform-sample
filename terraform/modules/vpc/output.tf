output "vpc" {
  value = "${
    map(
      "vpc_id",                "${ aws_vpc.vpc.id }",
      "subnet_front_a",        "${ aws_subnet.front_a.id }",
      "subnet_front_c",        "${ aws_subnet.front_c.id }",
      "subnet_front_d",        "${ aws_subnet.front_d.id }",
      "subnet_public_a",       "${ aws_subnet.public_a.id }",
      "subnet_public_c",       "${ aws_subnet.public_c.id }",
      "subnet_public_d",       "${ aws_subnet.public_d.id }",
      "subnet_private_web_a",  "${ aws_subnet.private_web_a.id }",
      "subnet_private_web_c",  "${ aws_subnet.private_web_c.id }",
      "subnet_private_web_d",  "${ aws_subnet.private_web_d.id }",
      "subnet_private_data_a", "${ aws_subnet.private_data_a.id }",
      "subnet_private_data_c", "${ aws_subnet.private_data_c.id }",
      "subnet_private_data_d", "${ aws_subnet.private_data_d.id }"
    )
  }"
}
