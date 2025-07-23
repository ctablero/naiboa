data "aws_ami" "amazon_linux" {
    most_recent = true
    owners = ["amazon"]

    filter {
        name   = "name"
        values = ["al2023-ami-2023.8.20250715.0-kernel-*-x86_64"]
    }
}

resource "aws_instance" "videogames_instance" {
    instance_type = var.instance_type
    ami = data.aws_ami.amazon_linux.id
    subnet_id = var.subnet_1_id
    vpc_security_group_ids = var.security_group_ids

    #Temporary disabled to not affect the free tier
    associate_public_ip_address = false

    #This references the name of a key pair coded above
    # Once associated key pair with this instance, you can ssh with the command (reference the private key) ssh -i ~/.ssh/videogames_instance ec2-user@<public-ip-address>
    key_name = var.instance_key_pair_name

    # Execute the script to install everything required for the videogames server
    user_data = file("./modules/webserver/entry-script.sh")
    user_data_replace_on_change = true

    tags = {
        Name = "${var.env_prefix}-videogames-instance-${var.instance_name}"
    }
}
