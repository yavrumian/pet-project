locals {
  default_tags = {
    Environment = var.environment
    Automation  = "Terraform"
  }

  private_subnets = "${data.terraform_remote_state.core.outputs.private_subnets["ap-northeast-3a"]},${data.terraform_remote_state.core.outputs.private_subnets["ap-northeast-3b"]},${data.terraform_remote_state.core.outputs.private_subnets["ap-northeast-3c"]}"
  public_subnets  = "${data.terraform_remote_state.core.outputs.public_subnets["ap-northeast-3a"]},${data.terraform_remote_state.core.outputs.public_subnets["ap-northeast-3b"]},${data.terraform_remote_state.core.outputs.public_subnets["ap-northeast-3c"]}"


}
