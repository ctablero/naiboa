resource "aws_alb" "stack_alb" {
    name               = "stack-alb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = var.alb_security_group_ids
    subnets            = var.subnets_ids

    tags = {
        Name = "${var.env_prefix}-stack-alb"
    }
}

resource "aws_alb_listener" "stack_alb_listener" {
    load_balancer_arn = aws_alb.stack_alb.arn
    port              = 80
    protocol          = "HTTP"

    # This is the default rule definition
    default_action {
        type          = "forward"
        target_group_arn = aws_alb_target_group.stack_alb_target_group.arn
    }

    tags = {
        Name = "${var.env_prefix}-stack-alb-listener"
    }
}

resource aws_alb_target_group "stack_alb_target_group" {
    name     = "stack-alb-target-group"
    port     = 8080
    protocol = "HTTP"
    vpc_id   = var.vpc_id

    tags = {
        Name = "${var.env_prefix}-stack-alb-target-group"
    }
}

resource aws_autoscaling_attachment "stack_autoscaling_attachment" {

    target_group_arn = aws_alb_target_group.stack_alb_target_group.arn
    autoscaling_group_arn        = var.autoscaling_group_arn
}
