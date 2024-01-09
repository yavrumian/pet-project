module "eks" {
  source                         = "terraform-aws-modules/eks/aws"
  version                        = "~> 19.21.0"
  cluster_name                   = local.eks_cluster_name
  cluster_version                = var.eks_cluster_version
  control_plane_subnet_ids       = module.vpc.private_subnets
  subnet_ids                     = module.vpc.private_subnets
  cluster_enabled_log_types      = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  enable_irsa                    = true
  vpc_id                         = module.vpc.vpc_id
  create_aws_auth_configmap      = false
  cluster_endpoint_public_access = true

  kms_key_owners = [
    "arn:aws:iam::617686195573:role/actions",
    "arn:aws:sts::617686195573:assumed-role/AWSReservedSSO_AdministratorAccess_e2fbc9f4f34d4116/oleksandr@naviteq.io",
    "arn:aws:iam::617686195573:user/vahe-yavrumian"
  ]

  cluster_addons = {
    vpc-cni = {
      resolve_conflicts_on_update = "PRESERVE"
      before_compute              = true
      most_recent                 = true # To ensure access to the latest settings provided
      configuration_values = jsonencode({
        env = {
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
  }

  eks_managed_node_group_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 60
  }

  eks_managed_node_groups = {
    default = {
      desired_size   = var.eks_node_desired_capacity
      max_size       = var.eks_node_max_capacity
      min_size       = var.eks_node_min_capacity
      instance_types = var.eks_node_instance_types
      capacity_type  = var.eks_node_capacity_type

      k8s_labels = {
        Environment = var.environment
      }

      additional_tags = {
        EKS = local.eks_cluster_name
      }
    }
  }
}
