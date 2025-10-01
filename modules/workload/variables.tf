variable "ami_id" {
    description = "AMI ID for the backend workloads"
    type        = string
}

variable "env_prefix" {
    description = "Environment prefix for resource naming"
    type        = string
}

variable "instance_key_pair_name" {
    description = "Name of the key pair to associate with the EC2 instance"
    type        = string
}

variable "instance_type" {
    description = "Instance type for the EC2 instance"
    type        = string
}

variable "min_size" {
    description = "Minimum size of the Auto Scaling group"
    type        = number
    default     = 1
}

variable "max_size" {
    description = "Maximum size of the Auto Scaling group"
    type        = number
    default     = 3
}

variable "security_group_ids" {
    description = "Security group IDs to associate with the workloads"
    type        = list(string)
}

variable "subnets_ids" {
    description = "List of subnet IDs for the backend instances"
    type        = list(string)
}
