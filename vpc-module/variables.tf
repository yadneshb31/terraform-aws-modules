#VARIABLES

variable "vpc_cidr" {
    description = "CIDR block for VPC"
    type = string
}

variable "vpc_name" {
    description = "name of vpc"
    type = string
}