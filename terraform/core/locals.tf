locals {
  default_tags = {
    Environment = var.environment
    Automation  = "Terraform"
    Owner       = "Vahe Yavrumian"
    Purpose     = "Assignment"
  }

  eks_cluster_name = "naviteq-${var.environment}-eks"
}
