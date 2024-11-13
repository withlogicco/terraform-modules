variable "name" {
  type        = string
  description = "The name of the IAM Role to create"
  nullable    = false
}

variable "policies" {
  type        = list(string)
  description = "The ARNs of the IAM Policies to attach to the IAM role"
  default     = []
}


variable "tags" {
  type        = map(string)
  description = "Tags of the IAM Role to create"
  default     = {}
}
