data "terraform_remote_state" "core" {
  backend = "s3"

  config = {
    bucket = "naviteq-${var.environment}-state"
    key    = "core-module/state.tfstate"
    region = "ap-northeast-3"
  }
}
data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.core.outputs.eks_cluster_name
}

data "aws_iam_role" "helm" {
  name = "actions"
}
