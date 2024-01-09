module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 1.6"

  for_each = toset(var.ecr_repository_name_list)

  repository_name               = each.key
  repository_image_scan_on_push = var.repository_image_scan_on_push

  repository_read_access_arns       = var.repository_read_access_arns
  repository_image_tag_mutability   = "MUTABLE"
  repository_read_write_access_arns = var.repository_read_write_access_arns
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "sinceImagePushed",
          countNumber   = 30
          countUnit     = "days"
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Type = "private"
  }
}
