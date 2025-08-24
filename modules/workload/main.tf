resource aws_autoscaling_group "workload_autoscaling_group" {
    min_size            = 1 # To parameterize
    max_size            = 3
    desired_capacity    = 1
    vpc_zone_identifier = var.subnets_ids

    tags = {
        Name = "${var.env_prefix}-workload"
    }
}

resource aws_launch_configuration "workload_launch_configuration" {
    name_prefix = "workload-"
    image_id = var.ami_id
    instance_type = var.instance_type
    security_groups = var.security_group_ids

    lifecycle {
        create_before_destroy = true
    }

    #Temporary disabled to not affect the free tier
    associate_public_ip_address = false

    #This references the name of a key pair coded above
    # Once associated key pair with this instance, you can ssh with the command (reference the private key) ssh -i ~/.ssh/identity-file ec2-user@<public-ip-address>
    key_name = var.instance_key_pair_name

    # Execute the script to install everything required for the workloads
    user_data = file("./modules/workload/entry-script.sh")
    user_data_replace_on_change = true
}