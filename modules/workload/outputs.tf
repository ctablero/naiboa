output "autoscaling_group_id" {
    value = aws_autoscaling_group.workload_autoscaling_group.id
}

output "autoscaling_group_name" {
    value = aws_autoscaling_group.workload_autoscaling_group.name
}