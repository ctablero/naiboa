provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "videogames_vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "${var.env_prefix}-videogames-vpc"
    }
}

module "videogames_networking" {
    source = "./modules/networking"

    subnet_cidr_block = var.subnet_cidr_block
    avail_zone        = var.avail_zone
    env_prefix        = var.env_prefix
    vpc_id            = aws_vpc.videogames_vpc.id
}

module "videogames_webserver" {
    source = "./modules/webserver"

    env_prefix              = var.env_prefix
    ingress_cidr_blocks     = var.ingress_cidr_blocks
    instance_type           = var.instance_type
    ssh_public_key_location = var.ssh_public_key_location
    subnet_1_id             = module.videogames_networking.subnet_1.id
    vpc_id                  = aws_vpc.videogames_vpc.id
}