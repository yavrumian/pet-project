locals {
  merged_map_users = [
    for user in var.map_users : {
      userarn  = user
      username = user
      groups   = ["system:masters"]
    }
  ]
  merged_map_roles = [
    {
      rolearn  = data.aws_iam_role.helm.arn
      username = data.aws_iam_role.helm.name
      groups   = ["admin"]
    },
    {
      rolearn  = "arn:aws:iam::617686195573:role/AWSReservedSSO_AdministratorAccess_e2fbc9f4f34d4116"
      username = "arn:aws:iam::617686195573:role/AWSReservedSSO_AdministratorAccess_e2fbc9f4f34d4116"
      groups   = ["system:masters"]
    },
    {
      rolearn  = data.terraform_remote_state.core.outputs.eks_cluster_eks_managed_node_group_iam_role_arn
      username = "system:node:{{EC2PrivateDNSName}}"

      groups = [
        "system:bootstrappers",
        "system:nodes",
      ]
    }
  ]
}

resource "kubernetes_config_map_v1_data" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    "mapRoles" = yamlencode(local.merged_map_roles)
    "mapUsers" = yamlencode(local.merged_map_users)
    #    "mapAccounts" = yamlencode(var.map_accounts)
  }

  force = true
}
