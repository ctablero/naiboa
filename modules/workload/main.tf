resource aws_autoscaling_group "workload_autoscaling_group" {
    min_size            = 1 # To parameterize
    max_size            = 3
    desired_capacity    = 1

    launch_template {
        id      = aws_launch_template.workload_launch_template.id
        version = "$Latest"
    }

    vpc_zone_identifier = var.subnets_ids
}

resource aws_launch_template "workload_launch_template" {
    name_prefix = "workload-"
    image_id = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = var.security_group_ids

    #This references the name of a key pair coded above
    # Once associated key pair with this instance, you can ssh with the command (reference the private key) ssh -i ~/.ssh/identity-file ec2-user@<public-ip-address>
    key_name = var.instance_key_pair_name

    user_data = filebase64("${path.module}/entry-script.sh")
}