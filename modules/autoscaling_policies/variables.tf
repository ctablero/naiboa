variable "autoscaling_group_name" {
    description = "Name of the Auto Scaling group to attach the policies"
    type        = string
}

variable "quantity_avg_cpu_utilization" {
    description = "Target average CPU utilization percentage for the Auto Scaling group policy"
    type        = number
    default     = 50
}

variable "quantity_request_count_per_target" {
    description = "Target request count per target for the Auto Scaling group policy"
    type        = number
    default     = 10
}

variable "resource_label" {
    description = "Resource label prepared to use with the ALBRequestCountPerTarget predefined metric. The format is app/<load-balancer-name>/<load-balancer-id>/targetgroup/<target-group-name>/<target-group-id>"
    type        = string
}