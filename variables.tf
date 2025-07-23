variable "avail_zone_a" {
    description = "Availability zone A for the development subnet"
    type        = string
}

variable "avail_zone_b" {
    description = "Availability zone B for the development subnet"
    type        = string
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

variable "ssh_public_key_location" {
    description = "This is the path of your generated public key, so you can provide aws for ssh key pair creation"
    type        = string 
}

variable "subnet_cidr_block_1" {
    description = ""
    type        = string
}

variable "subnet_cidr_block_2" {
    description = ""
    type        = string
}

variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    type        = string
}

variable "webserver_pool" {
    description = "List of backend servers"
    type        = list(string)
}