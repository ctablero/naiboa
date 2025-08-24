output "subnets_ids" {
    value = aws_subnet.stack_subnet_for_workloads[*].id
}
