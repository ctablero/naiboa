provider "aws" {
    region = "us-east-1"
}

variable "ami_id" {
    description = "AMI ID for the workload instances"
    type        = string
    default     = "ami-0cbbe2c6a1bb2ad63" # Example AMI ID, replace with your own
}

variable "asg_policy_target_avg_cpu_utilization" {
    description = "Target average CPU utilization percentage for the Auto Scaling group policy"
    type        = number
    default     = 50
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
}

variable "max_size" {
    description = "Maximum size of the Auto Scaling group"
    type        = number
}

variable "ssh_public_key_location" {
    description = "This is the path of your generated public key, so you can provide aws for ssh key pair creation"
    type        = string 
}

variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    type        = string
}

variable "subnets_specs" {
    description = "Specifications for the subnets to be created"
    type = map(object({
        avail_zone = string
        cidr_block = string
    }))
}

resource "aws_vpc" "stack_vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "stack-vpc"
    }
}

module "alb_with_autoscaling" {
    source = "../.."

    env_prefix              = "dev"
    asg_policy_target_avg_cpu_utilization = var.asg_policy_target_avg_cpu_utilization
    vpc_id                  = aws_vpc.stack_vpc.id
    ami_id                  = var.ami_id
    ingress_cidr_blocks     = var.ingress_cidr_blocks
    instance_type           = "t2.micro"
    min_size                = var.min_size
    max_size                = var.max_size
    subnets_specs           = var.subnets_specs
    ssh_public_key_location = var.ssh_public_key_location

}