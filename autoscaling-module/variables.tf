variable "subnet_ids" {
  description = "Private subnets"
  type        = list(string)
}

variable "security_group_id" {
  description = "EC2 security group"
  type        = string
}

variable "target_group_arn" {
  description = "Target group ARN"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}