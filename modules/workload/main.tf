resource aws_autoscaling_policy "workload_autoscaling_group_avg_cpu_utilization" {
    autoscaling_group_name = aws_autoscaling_group.workload_autoscaling_group.name
    name                   = "${var.env_prefix}-avg-cpu-utilization"

    policy_type = "TargetTrackingScaling"

    target_tracking_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = var.asg_policy_target_avg_cpu_utilization
    }

}

resource aws_autoscaling_group "workload_autoscaling_group" {
    min_size            = var.min_size
    max_size            = var.max_size

    launch_template {
        id      = aws_launch_template.workload_launch_template.id
        version = "$Latest"
    }

    vpc_zone_identifier = var.subnets_ids
}

resource aws_launch_template "workload_launch_template" {
    name_prefix            = "workload-"
    image_id               = var.ami_id
    instance_type          = var.instance_type
    vpc_security_group_ids = var.security_group_ids

    #This references the name of a key pair coded above
    # Once associated key pair with this instance, you can ssh with the command (reference the private key) ssh -i ~/.ssh/identity-file ec2-user@<public-ip-address>
    key_name  = var.instance_key_pair_name
}