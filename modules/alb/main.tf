resource "aws_alb" "videogames_alb" {
    name               = "videogames-alb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = var.alb_security_group_ids
    subnets            = [var.subnet_1_id, var.subnet_2_id]

    tags = {
        Name = "${var.env_prefix}-videogames-alb"
    }
}

resource "aws_alb_listener" "videogames_alb_listener" {
    load_balancer_arn = aws_alb.videogames_alb.arn
    port              = 80
    protocol          = "HTTP"

    # This is the default rule definition
    default_action {
        type          = "forward"
        target_group_arn = aws_alb_target_group.videogames_alb_target_group.arn
    }

    tags = {
        Name = "${var.env_prefix}-videogames-alb-listener"
    }
}

resource aws_alb_target_group "videogames_alb_target_group" {
    name     = "videogames-alb-target-group"
    port     = 8080
    protocol = "HTTP"
    vpc_id   = var.vpc_id

    tags = {
        Name = "${var.env_prefix}-videogames-alb-target-group"
    }
}

resource aws_alb_target_group_attachment "videogames_alb_target_group_attachments" {
    for_each = var.target_ids

    port             = 8080
    target_group_arn = aws_alb_target_group.videogames_alb_target_group.arn
    target_id        = each.value
}
