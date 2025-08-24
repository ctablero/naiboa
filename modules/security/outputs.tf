output "workload_security_group_ids" {
    value = [aws_security_group.workload_security_group.id]
}

output "alb_security_group_ids" {
    value = [aws_security_group.alb_security_group.id]
}

output "workload_instance_key_pair_name" {
    value = aws_key_pair.workload_instance_key_pair.key_name 
}