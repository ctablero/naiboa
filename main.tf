provider "aws" {
    region = "us-east-1"
}

variable "vg_dept_cidr_block" {
    description = "CIDR block for the VPC"
    type        = string
}

variable "vg_dept_dev_cidr_block" {
    description = "CIDR block for the development subnet"
    type        = string
}

variable "vg_dept_desg_cidr_block" {
    description = "CIDR block for the design subnet"
    type        = string
}

resource "aws_vpc" "vg-dept" {
    cidr_block = var.vg_dept_cidr_block
    tags = {
        Name = "vg-department"
    }
}

resource "aws_subnet" "vg-dept-dev" {
    vpc_id            = aws_vpc.vg-dept.id
    cidr_block        = var.vg_dept_dev_cidr_block
    availability_zone = "us-east-1a"
    tags              = {
        Name = "vg-department-dev"
    }
}

resource "aws_subnet" "vg-dept-desg" {
    vpc_id            = aws_vpc.vg-dept.id
    cidr_block        = var.vg_dept_desg_cidr_block
    availability_zone = "us-east-1a"
    tags              = {
        Name = "vg-department-desg"
    }
}

output "vg-dept-id" {
    value = aws_vpc.vg-dept.id
}

output "vg-dept-dev-id" {
    value = aws_subnet.vg-dept-dev.id
}

output "vg-dept-desg-id" {
    value = aws_subnet.vg-dept-desg.id
}