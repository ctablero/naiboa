module "networking" {
    source = "./modules/networking"

    env_prefix          = var.env_prefix
    subnets_specs       = var.subnets_specs
    vpc_id              = var.vpc_id
}

module "security" {
    source = "./modules/security"

    env_prefix              = var.env_prefix
    ingress_cidr_blocks     = var.ingress_cidr_blocks
    vpc_id                  = var.vpc_id
    ssh_public_key_location = var.ssh_public_key_location
}

module "alb" {
    source = "./modules/alb"

    alb_security_group_ids  = module.security.alb_security_group_ids
    autoscaling_group_id    = module.workload.autoscaling_group_id
    env_prefix              = var.env_prefix
    subnets_ids             = module.networking.subnets_ids
    vpc_id                  = var.vpc_id
}

module "workload" {
    source = "./modules/workload"

    ami_id                                  = var.ami_id
    env_prefix                              = var.env_prefix
    instance_type                           = var.instance_type
    instance_key_pair_name                  = module.security.workload_instance_key_pair_name
    max_size                                = var.max_size
    min_size                                = var.min_size
    security_group_ids                      = module.security.workload_security_group_ids
    subnets_ids                             = module.networking.subnets_ids
}

module "autoscaling_policies" {
    source = "./modules/autoscaling_policies"

    autoscaling_group_name            = module.workload.autoscaling_group_name
    quantity_avg_cpu_utilization      = var.quantity_avg_cpu_utilization
    quantity_request_count_per_target = var.quantity_request_count_per_target
    resource_label                    = module.alb.resource_label
}
