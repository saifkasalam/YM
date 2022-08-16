# Creating NATGW
resource "aws_eip" "natip" {
  vpc = true
    }

resource "aws_nat_gateway" "NATGW" {
  allocation_id = aws_eip.natip.id
  subnet_id     = aws_subnet.subnet01.id
  depends_on = [aws_internet_gateway.IGW]
    tags = {
    Name = "NATGW-YM-PROD"
  }
}
#CREATING ROUTE TABLE FOR PRIVATE SUBNET
resource "aws_route_table" "RBT02" {
  vpc_id = aws_vpc.VPC01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NATGW.id
  }

   tags = {
    Name = "Backend-RTB"
  }
}
# Subnet Association for Private Subnets

  resource "aws_route_table_association" "private1" {
  subnet_id = aws_subnet.subnet03.id
  route_table_id = aws_route_table.RBT02.id
  }

  resource "aws_route_table_association" "private2" {
   subnet_id = aws_subnet.subnet04.id 
   route_table_id = aws_route_table.RBT02.id
  }
  resource "aws_route_table_association" "private3" {
   subnet_id = aws_subnet.subnet05.id 
   route_table_id = aws_route_table.RBT02.id
  }
  resource "aws_route_table_association" "private4" {
   subnet_id = aws_subnet.subnet06.id 
   route_table_id = aws_route_table.RBT02.id
  }