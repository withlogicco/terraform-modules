variable "name" {
  description = "The name of the S3 bucket to create"
  type        = string
  nullable    = false
}

variable "versioning_enabled" {
  description = "Whether the S3 bucket should have object versioning enabled"
  type        = bool
  default     = true
}

variable "public" {
  description = "Whether the S3 bucket should allow public access"
  type        = bool
  default     = false
}

variable "tags" {
  description = "The tags to add to all resources"
  type        = map(string)
  default     = {}
}
