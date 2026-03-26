variable "subnet_ids" {
    description = "Private Subnet IDs"
    type = list(string)
}

variable "security_group_id" {
    description = "EC2 Security Group"
    type = string  
}

variable "instance_type" {
    description = "EC2 Instance type"
    type = string
    default = "t2.micro"  
}