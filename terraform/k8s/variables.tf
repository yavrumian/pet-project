variable "region" {
  description = "The region to deploy to"
  type        = string
  default     = "eu-north-1"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]{1}$", var.region))
    error_message = "The region should be in the format of xx-xxxx-x, where x is a lowercase letter or number."
  }
}

variable "environment" {
  description = "The environment the cluster will be deployed into"
  type        = string

  validation {
    condition     = can(regex("^(development|staging|production)$", var.environment))
    error_message = "The environment must be one of development, staging or production."
  }
}

variable "map_users" {
  description = "ARNs of AWS users to have access to EKS"
  type = list(string)
  default = []
}