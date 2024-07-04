resource "aws_vpc" "DT-vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = var.tags
}

data "aws_availability_zones" "AZs" {}


# Public Subnets
resource "aws_subnet" "pub_subs" {
  vpc_id                  = aws_vpc.DT-vpc.id
  count                   = length(var.pub_subs)
  availability_zone       = element(data.aws_availability_zones.AZs.names, count.index)
  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = var.pub_subs[count.index]
  }
}


# Private Subnets
resource "aws_subnet" "priv_subs" {
  vpc_id                  = aws_vpc.DT-vpc.id
  count                   = length(var.priv_subs)
  availability_zone       = element(data.aws_availability_zones.AZs.names, count.index)
  cidr_block              = var.private_subnet_cidrs[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = var.priv_subs[count.index]
  }
}


resource "aws_internet_gateway" "DT-IGW" {
  vpc_id = aws_vpc.DT-vpc.id

  tags = {
    Name = "${var.project-name}-IGW"
  }
}


resource "aws_eip" "DT-EIP" {
  depends_on = [aws_internet_gateway.DT-IGW]
}

resource "aws_nat_gateway" "DT-NGW" {
  subnet_id     = aws_subnet.pub_subs[0].id
  allocation_id = aws_eip.DT-EIP.id

  tags = {
    Name = "${var.project-name}-NGW"
  }
}

#Public Route table  
resource "aws_route_table" "pub_RT" {
  vpc_id = aws_vpc.DT-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.DT-IGW.id
  }

  tags = {
    Name = "${var.project-name}-public-route-table"
  }
}


# Private Route Table
resource "aws_route_table" "priv_RT" {
  vpc_id = aws_vpc.DT-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.DT-NGW.id
  }

  tags = {
    Name = "${var.project-name}-private-route-table"
  }
}

resource "aws_route_table_association" "pub-rt-1" {
  subnet_id      = aws_subnet.pub_subs[0].id
  route_table_id = aws_route_table.pub_RT.id
}


resource "aws_route_table_association" "pub-rt-2" {
  subnet_id      = aws_subnet.pub_subs[1].id
  route_table_id = aws_route_table.pub_RT.id
}

resource "aws_route_table_association" "priv-rt-1" {
  subnet_id      = aws_subnet.priv_subs[0].id
  route_table_id = aws_route_table.priv_RT.id
}

resource "aws_route_table_association" "priv-rt-2" {
  subnet_id      = aws_subnet.priv_subs[1].id
  route_table_id = aws_route_table.priv_RT.id
}