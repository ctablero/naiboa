variable "alb_security_group_ids" {
    description = "Security group IDs for the Application Load Balancer"
    type        = list(string)
}

variable "autoscaling_group_id" {
    description = "ID of the Auto Scaling group to register with the ALB target group"
    type        = string
}

variable "env_prefix" {
    description = "Environment prefix for resource naming"
    type        = string
}

variable "subnets_ids" {
    description = "List of subnet IDs for the workload instances"
    type        = list(string)
}

variable "vpc_id" {
    description = "ID of the VPC where the Application Load Balancer will be deployed"
    type        = string
}
