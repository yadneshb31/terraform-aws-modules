variable "vpc_id" {
    description = "VPC ID"
    type = string
}

variable "allowed_ssh_ip" {
    description = "IP allowed for SSH"
    type = string
    default = "0.0.0.0/0"
  
}