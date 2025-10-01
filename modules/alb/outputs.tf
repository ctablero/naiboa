output "resource_label" {
    value = "${aws_alb.stack_alb.arn_suffix}/${aws_alb_target_group.stack_alb_target_group.arn_suffix}"
}