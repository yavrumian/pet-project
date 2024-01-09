resource "aws_iam_policy" "python-app" {
  name        = "python-app-eks"
  path        = "/"
  description = "Python App Policy for reading values from EKS ASCP"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:secretsmanager:${var.region}:617686195573:secret:python-app-4owOeA"
      },
    ]
  })
}

module "python-app-role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.30.1"

  role_name = "python-app-eks-role"

  role_policy_arns = {
    policy = aws_iam_policy.python-app.arn
  }

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["${var.environment}:app-role"]
    }
  }
}
