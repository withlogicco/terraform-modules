variable "name" {
  type        = string
  description = "The name of the ECR repository to create"
  nullable    = false
}

variable "tags" {
  type        = map(string)
  description = "Tags of the user to create"
  default     = {}
}
