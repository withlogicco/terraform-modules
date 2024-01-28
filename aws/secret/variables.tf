variable "project" {
  type        = string
  description = "The name of the project using this secret (e.g. my-app)"
  nullable    = tru
}
variable "environment" {
  type        = string
  description = "The environment where this secret is being used (e.g. production)"
  nullable    = true
}
variable "domain" {
  type        = string
  description = "The domain name of the project of this secret (e.g. my-app.my-company.local)"
}
variable "secrets" {
  type        = list(map(any))
  sensitive   = true
  description = "List of key-value objects to merge and store in a single AWS secret"
  default     = []
}
