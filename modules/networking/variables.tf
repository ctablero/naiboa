variable "subnet_cidr_block" {
    description = "CIDR block for the development subnet"
    type        = string
}

variable "avail_zone" {
    description = "Availability zone for the development subnet"
    type        = string
}

variable "env_prefix" {
    description = "Environment prefix for resource naming"
    type        = string
}

variable "vpc_id" {
    description = "VPC ID where the subnet and other resources will be created"
    type        = string
}
