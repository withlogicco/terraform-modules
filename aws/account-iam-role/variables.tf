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

variable "account_id" {
  type        = string
  description = "The ID of the AWS Account to grant access to"
  nullable    = false
}
