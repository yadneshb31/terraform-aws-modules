variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}