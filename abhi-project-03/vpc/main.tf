resource "aws_vpc" "vpc_abhi" {
     cidr_block = "10.0.0.0/16"
     

     tags = {
        Name = "vpc-abhi"
     }
     
     }
     resource "aws_subnet" "public_subnet_01" {

        vpc_id = aws_vpc.vpc_abhi.id
        cidr_block = "10.0.1.0/24"
        map_public_ip_on_launch = true
        }

        resource "aws_subnet" "public_subnet_02" {
            vpc_id = aws_vpc.vpc_abhi.id
            cidr_block = "10.0.2.0/24"
            map_public_ip_on_launch = true
        }

  resource "aws_internet_gateway" "abhi_ig" {
     vpc_id = aws_vpc.vpc_abhi.id

  }

resource "aws_route_table" "public_RT" {
     vpc_id = aws_vpc.vpc_abhi.id 

     route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.abhi_ig.id

     }  
}


resource "aws_route_table_association" "abhi_public_subnet_01_ass" {
        subnet_id = aws_subnet.public_subnet_01.id
        route_table_id = aws_route_table.public_RT.id

}

resource "aws_route_table_association" "abhi_public_subnet-02_ass" {
        subnet_id = aws_subnet.public_subnet_02.id
        route_table_id = aws_route_table.public_RT.id
}

resource "aws_security_group" "abhi_sg" {
    name = "abhi_sg"
    description = "Allow SSH and HTTP traffic"
    vpc_id =aws_vpc.vpc_abhi.id

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

