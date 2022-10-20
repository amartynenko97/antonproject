resource "aws_vpc" "main" {
     cidr_block = "10.0.0.0/16"
     enable_dns_hostnames = "true"
     enable_dns_support   = "true"

     tags = {
         Name = "Environment-VPC"
  }
}

resource "aws_subnet" "main_public" {
     vpc_id                  = aws_vpc.main.id
     cidr_block              = var.vpc_cidr_public
     availability_zone       = "${var.aws_region}a"
     map_public_ip_on_launch = true

     tags = {
         Name = "Public-subnet"
 }
}

resource "aws_subnet" "main_private" {
     vpc_id                  = aws_vpc.main.id
     cidr_block              = var.vpc_cidr_private
     availability_zone       = "${var.aws_region}b"
     map_public_ip_on_launch = true

     tags = {
         Name = "Private-network"

 }
}

resource "aws_internet_gateway" "gateway" {
     vpc_id = "${aws_vpc.main.id}"

     tags = {
         Name = "internet-gateway"
  }
}

resource "aws_eip" "lb" {
     vpc = true
     depends_on = [aws_internet_gateway.gateway]
}

resource "aws_nat_gateway" "natgateway" {
     allocation_id = aws_eip.lb.id
     subnet_id     = aws_subnet.main_public.id

     tags = {
         Name = "Gateway-NAT"
  }

     depends_on = [aws_internet_gateway.gateway]
}

resource "aws_route_table" "public" {
     vpc_id = aws_vpc.main.id

  route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.gateway.id
  }

     tags = {
         Name = "Public-routetable"
  }
}

resource "aws_route_table" "private" {
     vpc_id = aws_vpc.main.id

  route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_nat_gateway.natgateway.id
  }

     tags =  {
         Name = "Private-routetable"
  }
}

resource "aws_route_table_association" "public" {
     count          = "${length(var.vpc_cidr_public)}"
     subnet_id      = "${element(aws_subnet.main_public.*.id, count.index)}"
     route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
     count          = "${length(var.vpc_cidr_private)}"
     subnet_id      = "${element(aws_subnet.main_private.*.id, count.index)}"
     route_table_id = "${aws_route_table.private.id}"
}