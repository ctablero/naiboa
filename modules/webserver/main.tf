resource "aws_security_group" "videogames_security_group" {
    name = "${var.env_prefix}-videogames-security-group"
    vpc_id = var.vpc_id

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
    instance_type = var.instance_type
    ami = data.aws_ami.amazon_linux.id
    subnet_id = var.subnet_1_id
    vpc_security_group_ids = [aws_security_group.videogames_security_group.id]

    #Temporary disabled to not affect the free tier
    associate_public_ip_address = false

    #This references the name of a key pair coded above
    # Once associated key pair with this instance, you can ssh with the command (reference the private key) ssh -i ~/.ssh/videogames_instance ec2-user@<public-ip-address>
    key_name = aws_key_pair.videogames_instance_key_pair.key_name

    # Execute the script to install everything required for the videogames server
    user_data = file("./modules/webserver/entry-script.sh")
    user_data_replace_on_change = true

    tags = {
        Name = "${var.env_prefix}-videogames-instance-${var.instance_name}"
    }
}
