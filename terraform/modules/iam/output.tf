output "iam" {
  value = "${
    map(
      "iamrole_task_web_arn",    "${ aws_iam_role.iamrole_task_web.arn }",
      "profile_ec2_bastion_arn", "${ aws_iam_instance_profile.profile_ec2_bastion.name }",
      "profile_ec2_web_arn",     "${ aws_iam_instance_profile.profile_ec2_web.name }"
    )
  }"
}

