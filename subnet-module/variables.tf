variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = map(string)
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = map(string)
}

variable "availability_zones" {
  description = "AZ mapping"
  type        = map(string)
}

variable "public_route_table_id" {
  description = "Public route table ID"
  type        = string
}

variable "create_nat_gateway" {
    description = "Whether to create NAT Gateway"
    type = bool
    default = true
}