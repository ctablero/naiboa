provider "aws" {
    region = "us-east-1"
}

# In Here was originally the main vpc, then was moved to the networking module
moved {
    from = aws_vpc.videogames_vpc
    to   = module.videogames_networking.aws_vpc.videogames_vpc
}

module "videogames_networking" {
    source = "./modules/networking"

    subnet_cidr_block = var.subnet_cidr_block
    avail_zone        = var.avail_zone
    env_prefix        = var.env_prefix
    vpc_cidr_block    = var.vpc_cidr_block
}

module "videogames_security" {
    source = "./modules/security"

    env_prefix              = var.env_prefix
    ingress_cidr_blocks     = var.ingress_cidr_blocks
    vpc_id                  = module.videogames_networking.vpc.id
    ssh_public_key_location = var.ssh_public_key_location
}

module "videogames_webserver" {
    source = "./modules/webserver"

    for_each                = toset(var.webserver_pool)
    instance_name           = each.value

    env_prefix              = var.env_prefix
    instance_type           = var.instance_type
    subnet_1_id             = module.videogames_networking.subnet_1.id
    security_group_ids      = module.videogames_security.videogames_security_group_ids
    instance_key_pair_name  = module.videogames_security.videogames_instance_key_pair_name
}