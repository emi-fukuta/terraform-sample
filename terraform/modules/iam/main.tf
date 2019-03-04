# IAM Role
resource "aws_iam_role" "iamrole_ec2_bastion" {
  name = "${ var.project["name"] }-${ var.env["zone_d"] }-iamrole-ec2-bastion"
  assume_role_policy = "${ data.aws_iam_policy_document.ec2_assume_role_policy.json }"
}

resource "aws_iam_role" "iamrole_ec2_web" {
  name = "${ var.project["name"] }-${ var.env["zone_d"] }-iamrole-ec2-web"
  assume_role_policy = "${ data.aws_iam_policy_document.ec2_assume_role_policy.json }"
}

resource "aws_iam_role" "iamrole_task_web" {
  name = "${ var.project["name"] }-${ var.env["zone_d"] }-iamrole-task-web"
  assume_role_policy = "${ data.aws_iam_policy_document.ecs_task_assume_role_policy.json }"
}

resource "aws_iam_role" "iamrole_task_exec_web" {
  name = "${ var.project["name"] }-${ var.env["zone_d"] }-iamrole-task-exec-web"
  assume_role_policy = "${ data.aws_iam_policy_document.ecs_task_assume_role_policy.json }"
}

# Attach Policy
resource "aws_iam_policy_attachment" "attach_policy_ssm" {
  name       = "${ var.project["name"] }-${ var.env["zone_d"] }-attach-policy-ssm"
  roles      = [
    "${ aws_iam_role.iamrole_ec2_bastion.name }",
    "${ aws_iam_role.iamrole_ec2_web.name }"
  ]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"  
}

resource "aws_iam_policy_attachment" "attach_policy_ecs" {
  name       = "${ var.project["name"] }-${ var.env["zone_d"] }-attach-policy-ssm"
  roles      = [
    "${ aws_iam_role.iamrole_ec2_bastion.name }",
    "${ aws_iam_role.iamrole_ec2_web.name }"
  ]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_policy_attachment" "attach_policy_s3" {
  name       = "${ var.project["name"] }-${ var.env["zone_d"] }-attach-policy-web"
  roles      = [
    "${ aws_iam_role.iamrole_task_web.name }"
  ]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_policy_attachment" "attach_policy_ecs_exec" {
  name       = "${ var.project["name"] }-${ var.env["zone_d"] }-attach-policy-task-exec"
  roles      = [
    "${ aws_iam_role.iamrole_task_exec_web.name }"
  ]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "profile_ec2_bastion" {
  name = "${ var.project["name"] }-${ var.env["zone_d"] }-profile-ec2-bastion"
  role = "${ aws_iam_role.iamrole_ec2_bastion.name }"
}

resource "aws_iam_instance_profile" "profile_ec2_web" {
  name  = "${ var.project["name"] }-${ var.env["zone_d"] }-profile-ec2-web"
  role  = "${ aws_iam_role.iamrole_ec2_web.name }"
}

