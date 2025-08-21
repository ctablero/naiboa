variable "env_prefix" {
    description = "Environment prefix for resource naming"
    type        = string
}

variable "instance_type" {
    description = "Instance type for the EC2 instance"
    type        = string
}

variable "subnet_1_id" {
    description = "Subnet ID where the EC2 instance will be launched"
    type        = string
}

variable "instance_name" {
    description = "Name of the EC2 instance"
    type        = string
}

variable "security_group_ids" {
    description = "Security group IDs to associate with the workloads"
    type        = list(string)
}

variable "instance_key_pair_name" {
    description = "Name of the key pair to associate with the EC2 instance"
    type        = string
}

variable "subnets_ids" {
    description = "List of subnet IDs for the backend instances"
    type        = list(string)
}

variable "ami_id" {
    description = "AMI ID for the backend workloads"
    type        = string
}

variable "instance_type" {
    description = "Instance type for the backend workloads"
    type        = string
}
