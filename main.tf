
resource "aws_vpc" "VPC" {
  cidr_block = var.Vpc-Network.cidr_block
  tags = {
    Name = var.Vpc-Network.name
  }

}
resource "aws_subnet" "My-subnet" {
  count             = length(var.Vpc-Network.public-subnet.cidr_block)
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.Vpc-Network.public-subnet.cidr_block[count.index]
  availability_zone = var.Vpc-Network.public-subnet.availability_zone[count.index]
  tags = {
    Name = var.Vpc-Network.public-subnet.name[count.index]
  }

}
resource "aws_security_group" "SG" {
  vpc_id = aws_vpc.VPC.id
  ingress {
    from_port   = var.Vpc-Network.public-subnet.security_groups-ingress.from_port
    to_port     =var.Vpc-Network.public-subnet.security_groups-ingress.to_port
    protocol    = var.Vpc-Network.public-subnet.security_groups-ingress.protocol
    cidr_blocks = var.Vpc-Network.public-subnet.security_groups-ingress.cidr_block
  }
  egress {
    from_port   = var.Vpc-Network.public-subnet.security_groups-egress.from_port
    to_port     = var.Vpc-Network.public-subnet.security_groups-egress.to_port
    cidr_blocks = var.Vpc-Network.public-subnet.security_groups-egress.cidr_block
    protocol    = var.Vpc-Network.public-subnet.security_groups-egress.protocol
  }
  tags = {
    Name = "Security-group"
  }

}
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "internet gateway"
  }


}
resource "aws_route_table" "Route" {
  vpc_id = aws_vpc.VPC.id
  route  {
    cidr_block = var.Vpc-Network.public-subnet.route-table.cidr_block[0]
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "My-routetable"
  }
}

resource "aws_route_table_association" "Association" {
  count = length(var.Vpc-Network.public-subnet.cidr_block)
  subnet_id      = aws_subnet.My-subnet[count.index].id
  route_table_id = aws_route_table.Route.id

}

resource "aws_instance" "instance" {
  count                       = length(var.Vpc-Network.public-subnet.launch_instance.name)
  ami                         = var.Vpc-Network.public-subnet.launch_instance.ami[count.index]
  instance_type               = var.Vpc-Network.public-subnet.launch_instance.instance_type[count.index]
  key_name                    = var.Vpc-Network.public-subnet.launch_instance.key_name

  subnet_id                   = aws_subnet.My-subnet[count.index].id
  security_groups             = [aws_security_group.SG.id]
  associate_public_ip_address = "true"
  tags = {
    Name = var.Vpc-Network.public-subnet.launch_instance.name[count.index]
  }
}