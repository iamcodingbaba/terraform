resource "aws_vpc" "VPC" {
  cidr_block       = "10.0.0.0/16"
  
  tags = {
    Name = "Terra-vpc"
  }
}
resource "aws_subnet" "public-1" {
  vpc_id     = aws_vpc.VPC.id
  availability_zone = "us-east-1a"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public-1"
  }
}

resource "aws_subnet" "public-2" {
  vpc_id     = aws_vpc.VPC.id
  availability_zone = "us-east-1b"
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public-2"
  }
}
resource "aws_subnet" "private-1" {
  vpc_id     = aws_vpc.VPC.id
  availability_zone = "us-east-1a"
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "private-1"
  }
}
resource "aws_subnet" "private-2" {
  vpc_id     = aws_vpc.VPC.id
  availability_zone = "us-east-1b"
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "private-2"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "IGW"
  }
}
resource "aws_eip" "EIP" {
  domain   = "vpc"
}
resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.EIP.id
  subnet_id     = aws_subnet.public-1.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "public-rout"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NAT.id
  }

  tags = {
    Name = "private-rout"
  }
}

resource "aws_route_table_association" "pub-as" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route_table_association" "pub-as1" {
  subnet_id      = aws_subnet.public-2.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route_table_association" "private-as" {
  subnet_id      = aws_subnet.private-1.id
  route_table_id = aws_route_table.private-rt.id
}
resource "aws_route_table_association" "private-as2" {
  subnet_id      = aws_subnet.private-2.id
  route_table_id = aws_route_table.private-rt.id
}
