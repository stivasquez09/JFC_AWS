output "eks_cluster_name" {
  value = module.eks_cluster.cluster_id
}

output "eks_node_group_security_group_id" {
  value = aws_security_group.eks_nodes_sg.id
}
