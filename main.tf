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

    subnet_cidr_block_1 = var.subnet_cidr_block_1
    subnet_cidr_block_2 = var.subnet_cidr_block_2
    avail_zone_a        = var.avail_zone_a
    avail_zone_b        = var.avail_zone_b
    env_prefix          = var.env_prefix
    vpc_cidr_block      = var.vpc_cidr_block
}

module "videogames_security" {
    source = "./modules/security"

    env_prefix              = var.env_prefix
    ingress_cidr_blocks     = var.ingress_cidr_blocks
    vpc_id                  = module.videogames_networking.vpc.id
    ssh_public_key_location = var.ssh_public_key_location
}

module "videogames_alb" {
    source = "./modules/alb"

    alb_security_group_ids = module.videogames_security.alb_security_group_ids
    env_prefix             = var.env_prefix
    subnet_1_id            = module.videogames_networking.subnet_1.id
    subnet_2_id            = module.videogames_networking.subnet_2.id
    vpc_id                 = module.videogames_networking.vpc.id
    target_ids             = { for key, value in module.videogames_webserver : key => value.instance.id}
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