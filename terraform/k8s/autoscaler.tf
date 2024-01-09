data "aws_iam_policy_document" "cluster-autoscaler" {
  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:DescribeInstanceTypes",
    ]
  }
}

resource "aws_iam_policy" "cluster-autoscaler" {
  name        = "iam-policy-${var.environment}-cluster-autoscaler"
  description = "Cluster Autoscaler policy"
  policy      = data.aws_iam_policy_document.cluster-autoscaler.json
}

module "eks_sa_iam_role_assume_autoscaler" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.10.0"

  create_role = true
  role_name   = "iam-role-${var.environment}-cluster-autoscaler"

  role_policy_arns = {
    autoscaler = aws_iam_policy.cluster-autoscaler.arn
  }

  oidc_providers = {
    one = {
      provider_arn               = data.terraform_remote_state.core.outputs.eks_cluster_oidc_provider_arn
      namespace_service_accounts = ["kube-system:cluster-autoscaler-aws-cluster-autoscaler"]
    }
  }
}

resource "helm_release" "cluster-autoscaler" {
  name             = "cluster-autoscaler"
  namespace        = "kube-system"
  version          = "9.21.1"
  chart            = "cluster-autoscaler"
  repository       = "https://kubernetes.github.io/autoscaler"
  force_update     = false
  create_namespace = true

  values = [
    templatefile("${path.module}/templates/autoscaler.yaml", {
      role_arn     = module.eks_sa_iam_role_assume_autoscaler.iam_role_arn
      cluster_name = data.terraform_remote_state.core.outputs.eks_cluster_name
      aws_region   = var.region
    })
  ]
}
