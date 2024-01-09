################
#### Global ####
################

region      = "ap-northeast-3"
environment = "development"

############################
#### Network associated ####
############################

cidr                       = "10.5.0.0/18"
public_subnets             = ["10.5.0.0/22", "10.5.4.0/22", "10.5.8.0/22"]
private_subnets            = ["10.5.12.0/22", "10.5.16.0/22", "10.5.20.0/22"]
database_subnets           = ["10.5.24.0/22", "10.5.28.0/22", "10.5.32.0/22"]
default_availability_zones = ["ap-northeast-3a", "ap-northeast-3b", "ap-northeast-3c"]


########################
#### EKS associated ####
########################

eks_node_instance_types = ["t3.small"]


########################
#### ECR associated ####
########################

repository_read_write_access_arns = ["arn:aws:iam::617686195573:user/vahe-yavrumian"]
ecr_repository_name_list          = ["development-python-app"]
