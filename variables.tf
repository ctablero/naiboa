variable "ami_id" {
    description = "AMI ID for the workload instances"
    type        = string
}

variable "desired_capacity" {
    description = "Desired capacity of the Auto Scaling group"
    type        = number
    default     = 1
}

variable "env_prefix" {
    description = "Environment prefix for resource naming"
    type        = string
}

variable "ingress_cidr_blocks" {
    description = "CIDR blocks for ingress rules"
    type        = list(string)
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

variable "ssh_public_key_location" {
    description = "This is the path of your generated public key, so you can provide aws for ssh key pair creation"
    type        = string 
}

variable "subnets_specs" {
    description = "Specifications for the subnets to be created"
    type = map(object({
        avail_zone = string
        cidr_block = string
    }))
}

variable "vpc_id" {
    description = "VPC ID where resources will be created"
    type        = string
}
