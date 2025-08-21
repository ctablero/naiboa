variable "alb_security_group_ids" {
    description = "Security group IDs for the Application Load Balancer"
    type        = list(string)
}

variable "subnet_1_id" {
    description = "ID of the first subnet for the Application Load Balancer"
    type        = string
}

variable "subnet_2_id" {
    description = "ID of the second subnet for the Application Load Balancer"
    type        = string
}

variable "target_ids" {
    description = "List of target IDs (EC2 instance IDs) to attach to the Application Load Balancer"
    type        = map(string)
}

variable "vpc_id" {
    description = "ID of the VPC where the Application Load Balancer will be deployed"
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

variable "autoscaling_group_arn" {
    description = "ARN of the Auto Scaling group to register with the ALB"
    type        = string
}