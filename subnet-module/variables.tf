variable "vpc_id" {
    description = "VPC ID where subnets will be created"
    type = string
  
}

variable "public_subnets" {
    description = "Map of public subnet CIDRs"
    type = map(string)
  
}

variable "private_subnets" {
    description = "Map of private subnet CIDRs"
    type = map(string)
  
}

variable "availability_zones" {
    description = "AZ Mapping"
    type = map(string)
  
}

variable "public_route_table_id" {
    description = "Public route table id from vpc module"
    type = string
  
}

variable "create_nat_gateway" {
    description = "Whether to create NAT Gateway"
    type = bool
    default = true
}