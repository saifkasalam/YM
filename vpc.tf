data "aws_availability_zones" "available" {
  state = "available"
}

#CREATING VPC
resource "aws_vpc" "VPC01" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "VPCYMPROD"
  }
}

#CREATING SUBNETS
resource "aws_subnet" "subnet01" {
  vpc_id     = aws_vpc.VPC01.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block = "192.168.101.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-ALB-A"
  }
}

resource "aws_subnet" "subnet02" {
  vpc_id     = aws_vpc.VPC01.id
   availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block = "192.168.102.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-ALB-B"
  }
}

resource "aws_subnet" "subnet03" {
  vpc_id     = aws_vpc.VPC01.id
  cidr_block = "192.168.11.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "Private-Subnet-Backend-A"
  }
}

resource "aws_subnet" "subnet04" {
  vpc_id     = aws_vpc.VPC01.id
  cidr_block = "192.168.12.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "Private-Subnet-Backend-B"
  }
}


resource "aws_subnet" "subnet05" {
  vpc_id     = aws_vpc.VPC01.id
  cidr_block = "192.168.21.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "Private-Subnet-RDS-A"
  }
}

resource "aws_subnet" "subnet06" {
  vpc_id     = aws_vpc.VPC01.id
  cidr_block = "192.168.22.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "Private-Subnet-RDS-B"
  }
}

# Creating IGW

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC01.id
  tags = {
    Name = "IGW-YM-PROD"
  }
}

# Creating Route Table for Public Subnets

resource "aws_route_table" "RBT01" {
  vpc_id = aws_vpc.VPC01.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
   tags = {
    "Name" = "ALB-RTB"
  }
}

# Subnet Association for Public Subnets
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.subnet01.id
  route_table_id = aws_route_table.RBT01.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.subnet02.id
  route_table_id = aws_route_table.RBT01.id
}


