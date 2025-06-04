resource "aws_security_group" "eks_nodes_sg" {
  name        = "${var.nombre}-eks-nodes-sg"
  description = "Allow traffic from ALB"
  vpc_id      = var.my_vpc_id

  ingress {
    from_port       = var.port
    to_port         = var.port
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.nombre}-eks-nodes-sg"
  }
}
#EKS Auto Mode

module "eks_cluster" {
  source                         = "terraform-aws-modules/eks/aws"
  cluster_name                   = var.cluster_name
  cluster_version                = var.cluster_version
  subnet_ids                     = var.my_subnets
  vpc_id                         = var.my_vpc_id
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      desired_capacity = var.node_desired_capacity
      max_capacity     = var.node_max_capacity
      min_capacity     = var.node_min_capacity

      instance_types  = var.node_instance_types
      capacity_type   = "ON_DEMAND"
      security_groups = [aws_security_group.eks_nodes_sg.id]
    }
  }
  cloudwatch_log_group_retention_in_days = 7
  tags                                   = var.tags
}
