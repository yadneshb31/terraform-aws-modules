output "vpc_id" {
    value = aws_vpc.main_vpc.id
}

output "igw_id" {
    value = aws_internet_gateway.igw.id
  
}


output "public_route_table_id" {
    value = aws_route_table.public_rt.id
  
}