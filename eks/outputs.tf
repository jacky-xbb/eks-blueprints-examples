output "cluster_id" {
  value = module.eks_blueprints.eks_cluster_id
}

output "cluster_endpoint" {
  value = module.eks_blueprints.eks_cluster_endpoint
}

output "eks_cluster_version" {
  value = module.eks_blueprints.eks_cluster_version
}
