# creating VPC

resource "aws_vpc" "cicd_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "My-VPC"
  }
}

# creating Public Subnet

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.cicd_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet"
  }
}

# creating Private Subnet

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.cicd_vpc.id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = "Private-Subnet"
  }
}

# creating Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.cicd_vpc.id

  tags = {
    Name = "IGW"
  }
}

# Public Route Table

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.cicd_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associate Public Subnet with public route table

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Creating Elastic IP for NAT
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# NAT Gateway

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "NAT-Gateway"
  }
}

# Private Route Table

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.cicd_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

# Associate Private Subnet with private route table

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

