variable "name" {
  description = "The name of the ElastiCache cluster"
  type        = string
  nullable    = false
}

variable "node_type" {
  description = "The type of node to use"
  type        = string
  nullable    = false
  default     = "cache.t4g.micro"
}

variable "subnet_ids" {
  description = "The IDs of the subnets in which to place the ElastiCache cluster"
  type        = list(string)
  nullable    = false
}

variable "security_group_ids" {
  description = "The IDs of the security groups in which to place the ElastiCache cluster"
  type        = list(string)
  nullable    = false
}
