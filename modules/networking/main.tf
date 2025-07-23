resource "aws_vpc" "videogames_vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "${var.env_prefix}-videogames-vpc"
    }
}

resource "aws_internet_gateway" "videogames_internet_gateway" {
    vpc_id = aws_vpc.videogames_vpc.id

    tags   = {
        Name = "${var.env_prefix}-videogames-internet-gateway"
    }
}

resource "aws_subnet" "videogames_subnet_1" {
    vpc_id            = aws_vpc.videogames_vpc.id
    cidr_block        = var.subnet_cidr_block_1
    availability_zone = var.avail_zone_a
    tags              = {
        Name = "${var.env_prefix}-videogames-subnet-1"
    }
}

resource "aws_subnet" "videogames_subnet_2" {
    vpc_id            = aws_vpc.videogames_vpc.id
    cidr_block        = var.subnet_cidr_block_2
    availability_zone = var.avail_zone_b
    tags              = {
        Name = "${var.env_prefix}-videogames-subnet-2"
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

resource "aws_route_table_association" "videogames_route_table_association_subnet_1" {
    subnet_id      = aws_subnet.videogames_subnet_1.id
    route_table_id = aws_route_table.videogames_route_table.id
}

resource "aws_route_table_association" "videogames_route_table_association_subnet_2" {
    subnet_id = aws_subnet.videogames_subnet_2.id
    route_table_id = aws_route_table.videogames_route_table.id
}
