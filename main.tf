resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC"
  }

}
resource "aws_subnet" "my-subnet" {

  vpc_id            = aws_vpc.my-vpc.id
  availability_zone = "ap-south-1a"
  cidr_block        = "10.0.0.0/24"
  tags = {
    Name = "public-subnet1"
  }

}

resource "aws_subnet" "my-subnet1" {
  vpc_id            = aws_vpc.my-vpc.id
  availability_zone = "ap-south-1b"
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "public-subnet2"
  }

}

resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "vpc network internet"
  }

}
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG.id
  }
  tags = {
    Name = "route-table"
  }

}
resource "aws_route_table_association" "TASS" {
  subnet_id      = aws_subnet.my-subnet.id
  route_table_id = aws_route_table.RT.id
}
resource "aws_route_table_association" "TASS1" {
  route_table_id = aws_route_table.RT.id
  subnet_id      = aws_subnet.my-subnet1.id
}

resource "aws_security_group" "SG" {
  description = "allowing the ssh"
  vpc_id      = aws_vpc.my-vpc.id
  ingress {
    from_port   = "22"
    to_port     = "22"
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "vpc-security-group"
  }

}
resource "aws_instance" "my-instance" {
  ami                         = "ami-0c7632fb77f35db43"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.my-subnet.id
  security_groups             = [aws_security_group.SG.id]
  key_name                    = "key-pair"
  associate_public_ip_address = "true"
  tags = {
    Name = "instance1"
  }

}
resource "aws_instance" "my-instance1"{
    ami                         = "ami-0c7632fb77f35db43"
    instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.my-subnet1.id
  security_groups             = [aws_security_group.SG.id]
  key_name                    = "key-pair"
  associate_public_ip_address = "true"
  tags = {
    Name = "instance2"
  }

}
