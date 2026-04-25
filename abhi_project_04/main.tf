resource "aws_vpc" "abhi_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "Abhi_VPC"
    }
}

resource "aws_subnet" "public_subnet_01" {
    vpc_id = aws_vpc.abhi_vpc.id
    cidr_block = var.public_subnet_01_cidr
    availability_zone = "us-east-1a"
    tags = {
        Name = "Public_Subnet_01"
    }
}
resource "aws_subnet" "public_subnet_02" {
    vpc_id = aws_vpc.abhi_vpc.id
    cidr_block = var.public_subnet_02_cidr
    availability_zone = "us-east-1b"
    tags = {
        Name = "Public_Subnet_02"
    }
} 

resource "aws_internet_gateway" "abhi_ig" {
    vpc_id = aws_vpc.abhi_vpc.id
}

resource "aws_route_table" "public_RT" {
    vpc_id = aws_vpc.abhi_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.abhi_ig.id
    }
}

resource "aws_route_table_association" "abhi_public_subnet_01_association" {
    subnet_id = aws_subnet.public_subnet_01.id
    route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table_association" "abhi_public_subnet_02_association" {
    subnet_id = aws_subnet.public_subnet_02.id
    route_table_id = aws_route_table.public_RT.id
}

resource "aws_security_group" "abhi_sg" {
    name = "abhi_sg"
    description = "Allow SSH and HTTP traffic"
    vpc_id =aws_vpc.abhi_vpc.id

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "Allow all outbound traffic"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags ={
        Name = "abhi_sg"
    }
}
