# ECR
resource "aws_ecr_repository" "nginx" {
  name = "${ var.project["name"] }-${ var.env["zone_d"] }-nginx"
}

resource "aws_ecr_repository" "api" {
  name = "${ var.project["name"] }-${ var.env["zone_d"] }-api"
}

# ECS Cluster
resource "aws_ecs_cluster" "cluster_api" {
  name = "${ var.project["name"] }-${ var.env["zone_d"] }-cluster-api"
}

