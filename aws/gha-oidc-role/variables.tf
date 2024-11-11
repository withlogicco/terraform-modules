variable "name" {
  type        = string
  description = "The name of the IAM Role to create"
  nullable    = false
}

variable "idp_arn" {
  type        = string
  description = "The ARN of the GitHub Actions IAM Identity Provider"
  nullable    = false
}

variable "github_repos" {
  type        = string
  description = "The GitHub repos (e.g. org/repo-name or org/*) to grant access to"
  nullable    = false
}

variable "github_branches" {
  type        = string
  description = "The branches in the GitHub repos to grant access to"
  default     = "*"
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
