output "alb" {
  value = "${
    map(
      "alb_web_arn", "${ aws_lb.web.arn }"
    )
  }"
}

