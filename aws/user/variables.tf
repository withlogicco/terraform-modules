variable "name" {
  type        = string
  description = "The name of the user to create"
  nullable    = false
}

variable "policies" {
  type        = list(string)
  description = "The ARNs of the policies to attach to the user"
  default     = []
}

variable "groups" {
  type        = list(string)
  description = "The names of the groups of make the user a member of"
  default     = []
}


variable "tags" {
  type        = object
  description = "Tags of the user to create"
  default     = {}
}
