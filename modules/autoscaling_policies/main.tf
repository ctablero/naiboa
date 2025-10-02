resource aws_autoscaling_policy "asg_policy_avg_cpu_utilization" {
    autoscaling_group_name = var.autoscaling_group_name
    name                   = "asg-policy-avg-cpu-utilization"

    policy_type            = "TargetTrackingScaling"

    target_tracking_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = var.quantity_avg_cpu_utilization
    }
}

resource aws_autoscaling_policy "asg_policy_alb_request_count_per_target" {
    autoscaling_group_name = var.autoscaling_group_name
    name                   = "asg-policy-alb-request-count-per-target"

    policy_type            = "TargetTrackingScaling"

    target_tracking_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ALBRequestCountPerTarget"
            resource_label         = var.resource_label
        }

        target_value = var.quantity_request_count_per_target
    }
}