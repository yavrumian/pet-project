variable "region" {
  description = "The region to deploy to."
  type        = string
  default     = "eu-north-1"
}

variable "environment" {
  description = "The environment to deploy to."
  type        = string
}

variable "cidr" {
  description = "The IPv4 CIDR block for the VPC."
  type        = string
}

variable "default_availability_zones" {
  description = "Default list of availability zones names or ids in the region."
  type        = list(string)
  default     = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]

  validation {
    condition     = length(var.default_availability_zones) >= 2
    error_message = "The default_availability_zones variable must contain at least 2 availability zones."
  }
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC."
  type        = list(string)

  validation {
    condition     = length(var.public_subnets) >= 1
    error_message = "At least one public subnet is required."
  }
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC."
  type        = list(string)

  validation {
    condition     = length(var.private_subnets) >= 2
    error_message = "At least 2 private subnets are required."
  }
}

variable "database_subnets" {
  description = "A list of database subnets."
  type        = list(string)

  validation {
    condition     = length(var.database_subnets) >= 2
    error_message = "At least 2 database subnets are required."
  }
}

variable "eks_cluster_version" {
  description = "The EKS cluster version."
  type        = string
  default     = "1.28"

  validation {
    condition     = contains(["1.27", "1.28"], var.eks_cluster_version)
    error_message = "EKS cluster version must be one of 1.27, 1.28."
  }
}

variable "eks_node_desired_capacity" {
  description = "The desired number of worker nodes."
  type        = number
  default     = 1

  validation {
    condition     = var.eks_node_desired_capacity >= 1
    error_message = "The desired number of worker nodes must be greater than or equal to 1."
  }
}

variable "eks_node_max_capacity" {
  description = "The maximum number of worker nodes."
  type        = number
  default     = 3
}

variable "eks_node_min_capacity" {
  description = "The minimum number of worker nodes."
  type        = number
  default     = 1
}

variable "eks_node_instance_types" {
  description = "A list of instance types of worker nodes."
  type        = list(string)
  default     = ["t3.large", "t3.nano", "t3a.medium", "t2.large", "m6i.large", "m6a.large", "m5.large", "m5a.large", "m5n.large", "m5zn.large", "m4.large"]

  validation {
    condition     = length(var.eks_node_instance_types) > 0
    error_message = "At least one instance type must be specified."
  }
}

variable "eks_node_capacity_type" {
  description = "The type of worker nodes."
  type        = string
  default     = "ON_DEMAND"

  validation {
    condition     = contains(["SPOT", "ON_DEMAND"], var.eks_node_capacity_type)
    error_message = "The value must be SPOT or ON_DEMAND."
  }
}

variable "ecr_repository_name_list" {
  description = "List of names of ECR repositories"
  type        = list(string)
  default     = []
}

variable "repository_read_access_arns" {
  description = "The ARNs of the IAM users/roles that have read access to the repository"
  type        = list(string)
  default     = []
}

variable "repository_read_write_access_arns" {
  description = "The ARNs of the IAM users/roles that have read/write access to the repository"
  type        = list(string)
  default     = []
}

variable "repository_image_scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository (`true`) or not scanned (`false`)"
  type        = bool
  default     = false
}
