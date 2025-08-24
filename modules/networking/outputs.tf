output "subnets_ids" {
    value = values(aws_subnet.stack_subnet_for_workloads)[*].id
}
