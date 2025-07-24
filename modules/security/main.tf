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
        security_groups = [aws_security_group.alb_security_group.id]
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

resource "aws_security_group" "alb_security_group" {
    
    name = "${var.env_prefix}-alb-security-group"
    vpc_id = var.vpc_id

    tags = {
        Name = "${var.env_prefix}-alb-security-group"
    }
}

resource "aws_security_group_rule" "alb_security_group_rule_http_inbound_worldwide" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "TCP"
    security_group_id = aws_security_group.alb_security_group.id
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_security_group_rule_http_outbound_webservers" {
    type = "egress"
    from_port = 8080
    to_port = 8080
    protocol = "TCP"
    security_group_id = aws_security_group.alb_security_group.id
    source_security_group_id = aws_security_group.videogames_security_group.id
}

resource "aws_key_pair" "videogames_instance_key_pair" {

    key_name = "videogames-server-key"
    public_key = file(var.ssh_public_key_location)
}
