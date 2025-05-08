provider "aws" {
    region = "us-east-1"
}

variable "env_prefix" {
    description = "Environment prefix for resource naming"
    type        = string
}

variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    type        = string
}

variable "subnet_cidr_block" {
    description = "CIDR block for the development subnet"
    type        = string
}

variable "ingress_cidr_blocks" {
    description = "CIDR blocks for ingress rules"
    type        = list(string)
}

variable "avail_zone" {
    description = "Availability zone for the development subnet"
    type        = string
}

variable "ssh_public_key_location" {
    description = "This is the path of your generated public key, so you can provide aws for ssh key pair creation"
    type = string 
}

resource "aws_vpc" "videogames_vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "${var.env_prefix}-videogames-vpc"
    }
}

resource "aws_subnet" "videogames_subnet_1" {
    vpc_id            = aws_vpc.videogames_vpc.id
    cidr_block        = var.subnet_cidr_block
    availability_zone = var.avail_zone
    tags              = {
        Name = "${var.env_prefix}-videogames-subnet-1"
    }
}

resource "aws_route_table" "videogames_route_table" {
    vpc_id = aws_vpc.videogames_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.videogames_internet_gateway.id
    }

    tags  = {
        Name = "${var.env_prefix}-videogames-route-table"
    }
}

resource "aws_route_table_association" "videogames_route_table_association" {
    subnet_id      = aws_subnet.videogames_subnet_1.id
    route_table_id = aws_route_table.videogames_route_table.id
}

resource "aws_internet_gateway" "videogames_internet_gateway" {
    vpc_id = aws_vpc.videogames_vpc.id

    tags   = {
        Name = "${var.env_prefix}-videogames-internet-gateway"
    }
}

resource "aws_security_group" "videogames_security_group" {
    name = "${var.env_prefix}-videogames-security-group"
    vpc_id = aws_vpc.videogames_vpc.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "TCP"
        cidr_blocks = var.ingress_cidr_blocks
    }

    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []
    }

    tags = {
        Name = "${var.env_prefix}-videogames-security-group"
    }
}

data "aws_ami" "amazon_linux" {
    most_recent = true
    owners = ["amazon"]

    filter {
        name   = "name"
        values = ["al2023-ami-2023.7.20250414.0-kernel-*-x86_64"]
    }
}

resource "aws_key_pair" "videogames_instance_key_pair" {

    key_name = "videogames-server-key"
    public_key = file(var.ssh_public_key_location)
}

resource "aws_instance" "videogames_instance" {
    instance_type = "t2.micro"
    ami = data.aws_ami.amazon_linux.id
    subnet_id = aws_subnet.videogames_subnet_1.id
    vpc_security_group_ids = [aws_security_group.videogames_security_group.id]

    associate_public_ip_address = true

    #This references the name of a key pair coded above
    # Once associated key pair with this instance, you can ssh with the command (reference the private key) ssh -i ~/.ssh/videogames_instance ec2-user@<public-ip-address>
    key_name = aws_key_pair.videogames_instance_key_pair.key_name

    tags = {
        Name = "${var.env_prefix}-videogames-instance"
    }
}

output "aws_ami_id" {
    value = data.aws_ami.amazon_linux.id
}

output "assigned_public_ip" {
    value = aws_instance.videogames_instance.public_ip
}