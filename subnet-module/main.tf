resource "aws_subnet" "public" {
    for_each = var.public_subnets
    vpc_id = var.vpc_id
    cidr_block = each.value
    availability_zone = var.availability_zones[each.key] 
    map_public_ip_on_launch = true

    tags = {
      Name = each.key
    }  
}

resource "aws_subnet" "private" {
    for_each = var.private_subnets
    vpc_id = var.vpc_id
    cidr_block = each.value
    availability_zone = var.availability_zones[each.key] 
    map_public_ip_on_launch = false

    tags = {
      Name = each.key
    }
}

resource "aws_route_table_association" "public_assoc" {
  for_each = aws_subnet.public

  subnet_id = each.value.id
  route_table_id = var.public_route_table_id
  
}

#Setup for Private Subnet communication model -----------------------------------------------------------------------------------------------------

resource "aws_eip" "nat_eip" {
  count = var.create_nat_gateway ? 1 : 0
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
  
}

resource "aws_nat_gateway" "nat" {
  count = var.create_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat_eip[0].id
  subnet_id = values(aws_subnet.public)[0].id
  tags = {
    Name = "main-nat-gateway"
  }
  depends_on = [aws_eip.nat_eip]
  
}

resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id
  tags = {
    Name = "private-rt"
  }
}


resource "aws_route" "private_internet_route" {
  route_table_id = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0 "
  nat_gateway_id = aws_nat_gateway.nat[0].id #"Give me the FIRST (and only) NAT Gateway"
  depends_on = [ aws_nat_gateway.nat ]
}

resource "aws_route_table_association" "private_assoc" {
  for_each = var.aws_subnet.private
  subnet_id = each.value.id
  route_table_id = aws_route_table.private_rt.id
  
}