/************
  NETWORKING
 ************/

########################
#### VPC associated ####
########################

output "vpc_arn" {
  description = "The ARN of the VPC."
  value       = module.vpc.vpc_arn
}

output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC."
  value       = module.vpc.vpc_cidr_block
}

########################################
#### Public subnet/route associated ####
########################################

output "public_subnets" {
  description = "Map of IDs of public subnets."
  value       = { for index, subnet in module.vpc.public_subnets : var.default_availability_zones[index] => subnet }
}

output "public_subnet_arns" {
  description = "Map of ARNs of public subnets."
  value       = { for index, arn in module.vpc.public_subnet_arns : var.default_availability_zones[index] => arn }
}

output "public_route_table_id" {
  description = "ID of public route table."
  value       = module.vpc.public_route_table_ids[0]
}

output "public_subnets_cidr_blocks" {
  description = "Map of cidr_blocks of public subnets"
  value       = { for index, subnet in module.vpc.public_subnets_cidr_blocks : var.default_availability_zones[index] => subnet }
}

#########################################
#### Private subnet/route associated ####
#########################################

output "private_subnets" {
  description = "Map of IDs of private subnets."
  value       = { for index, subnet in module.vpc.private_subnets : var.default_availability_zones[index] => subnet }
}

output "private_subnet_arns" {
  description = "Map of ARNs of private subnets."
  value       = { for index, arn in module.vpc.private_subnet_arns : var.default_availability_zones[index] => arn }
}

output "private_route_table_ids" {
  description = "Map of IDs of private route tables."
  value       = { for index, id in module.vpc.private_route_table_ids : var.default_availability_zones[index] => id }
}

output "private_subnets_cidr_blocks" {
  description = "Map of cidr_blocks of private subnets"
  value       = { for index, subnet in module.vpc.private_subnets_cidr_blocks : var.default_availability_zones[index] => subnet }
}

##########################################
#### Database subnet/route associated ####
##########################################

output "database_subnets" {
  description = "Map of IDs of database subnets."
  value       = { for index, subnet in module.vpc.database_subnets : var.default_availability_zones[index] => subnet }
}

output "database_subnet_arns" {
  description = "Map of ARNs of database subnets."
  value       = { for index, arn in module.vpc.database_subnet_arns : var.default_availability_zones[index] => arn }
}

output "database_subnet_group" {
  description = "ID of database subnet group."
  value       = module.vpc.database_subnet_group
}

output "database_route_table_ids" {
  description = "Map of IDs of database route tables."
  value       = { for index, id in module.vpc.database_route_table_ids : var.default_availability_zones[index] => id }
}

output "database_subnets_cidr_blocks" {
  description = "Map of cidr_blocks of database subnets"
  value       = { for index, subnet in module.vpc.database_subnets_cidr_blocks : var.default_availability_zones[index] => subnet }
}


#########################################
#### Internet/NAT Gateway associated ####
#########################################

output "igw_arn" {
  description = "The ARN of the Internet Gateway."
  value       = module.vpc.igw_arn
}

output "igw_id" {
  description = "The ID of the Internet Gateway."
  value       = module.vpc.igw_id
}

output "nat_public_ips" {
  description = "Map of public Elastic IPs created for AWS NAT Gateway."
  value       = { for index, ip in module.vpc.nat_public_ips : var.default_availability_zones[index] => ip }
}

########################
#### EKS associated ####
########################

output "eks_cluster_name" {
  description = "The name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "eks_cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = module.eks.cluster_arn
}

output "eks_cluster_certificate_authority_data" {
  description = "The base64 encoded certificate data required to communicate with your cluster."
  value       = module.eks.cluster_certificate_authority_data
}

output "eks_cluster_endpoint" {
  description = "The endpoint for your Kubernetes API server."
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_id" {
  description = "The name of the cluster."
  value       = module.eks.cluster_id
}

output "eks_cluster_oidc_provider_arn" {
  description = "The OIDC provider ARN of the cluster."
  value       = module.eks.oidc_provider_arn
}

output "eks_cluster_eks_managed_node_group_iam_role_arn" {
  description = "The IAM role ARN of the EKS managed node group."
  value       = module.eks.eks_managed_node_groups["default"].iam_role_arn
}
