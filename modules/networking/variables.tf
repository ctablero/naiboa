variable "env_prefix" {
    description = "Environment prefix for resource naming"
    type        = string
}

variable "subnets_specs" {
    description = "Specifications for the subnets to be created"
    type        = map(object({
        avail_zone = string
        cidr_block = string
    }))
}

variable "vpc_id" {
    description = "ID of the VPC to create resources in"
    type        = string
}
