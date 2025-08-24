resource "aws_internet_gateway" "stack_internet_gateway" {
    vpc_id = var.vpc_id

    tags   = {
        Name = "${var.env_prefix}-stack-internet-gateway"
    }
}

resource "aws_subnet" "stack_subnet_for_workloads" {
    for_each = var.subnets_specs

    vpc_id            = var.vpc_id
    availability_zone = each.value.avail_zone    
    cidr_block        = each.value.cidr_block
    tags              = {
        Name = "${var.env_prefix}-stack-subnet-${each.value.avail_zone}"
    }
}

resource "aws_route_table" "stack_route_table" {
    vpc_id = var.vpc_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.stack_internet_gateway.id
    }

    tags  = {
        Name = "${var.env_prefix}-stack-route-table"
    }
}

resource "aws_route_table_association" "route_table_association_subnets_for_workloads" {
    for_each = aws_subnet.stack_subnet_for_workloads
    subnet_id      = each.value.id
    route_table_id = aws_route_table.stack_route_table.id
}
