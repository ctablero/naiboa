variable "subnet_cidr_block_1" {
    description = "CIDR block for the development subnet 1"
    type        = string
}

variable "subnet_cidr_block_2" {
    description = "CIDR block for the development subnet 2"
    type        = string
}

variable "avail_zone_a" {
    description = "Availability zone A for the development subnet 1"
    type        = string
}

variable "avail_zone_b" {
    description = "Availability zone B for the development subnet 2"
    type        = string
}

variable "env_prefix" {
    description = "Environment prefix for resource naming"
    type        = string
}

variable "vpc_cidr_block" {
    description = "CIDR block for the development vpc"
    type        = string
}
