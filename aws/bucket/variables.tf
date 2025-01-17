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

variable "bucket_policy" {
  description = "A bucket policy document to attach to the bucket"
  type = object({
    Version = string
    Statement = list(object({
      Sid       = string
      Effect    = string
      Principal = map(string)
      Action    = list(string)
      Resource  = list(string)
    }))
  })
  default = null
}

variable "tags" {
  description = "The tags to add to all resources"
  type        = map(string)
  default     = {}
}
