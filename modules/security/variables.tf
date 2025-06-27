variable "env_prefix" {
    description = "Environment prefix for resource naming"
    type        = string
}

variable "ingress_cidr_blocks" {
    description = "CIDR blocks for ingress rules"
    type        = list(string)
}

variable "vpc_id" {
    description = "VPC ID where the subnet and other resources will be created"
    type        = string
}

variable "ssh_public_key_location" {
    description = "Location of the SSH public key for EC2 instance"
    type        = string
}
