# eks.tf

# 1. Configure the AWS Provider
# Specifies the AWS region where resources will be created.
provider "aws" {
  region = "ap-southeast-1" # You can change this to your preferred region
}

# 2. Create a VPC for our EKS Cluster
# EKS requires a VPC with at least two subnets in different Availability Zones.
# Using the official Terraform AWS VPC module simplifies this process.
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "richard-eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-southeast-1a", "ap-southeast-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    "Terraform"   = "true"
    "Environment" = "dev"
  }
}

# 3. Create IAM Role for the EKS Cluster
# This role is assumed by the EKS control plane to manage AWS resources.
resource "aws_iam_role" "eks_cluster_role" {
  name = "richard-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach the required AmazonEKSClusterPolicy to the role.
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# 4. Create IAM Role for the Worker Nodes
# This role is assumed by the EC2 instances in the node group.
resource "aws_iam_role" "eks_nodes_role" {
  name = "richard-eks-node-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach the three required policies for worker nodes.
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes_role.name
}

# 5. Create the EKS Cluster
# This defines the main EKS control plane.
resource "aws_eks_cluster" "my_cluster" {
  name     = "richard-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = module.vpc.private_subnets
  }

  # Ensure the IAM role is created with its policies before the cluster is created.
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}

# 6. Create the EKS Node Group
# This creates the EC2 instances that will register with the EKS cluster.
resource "aws_eks_node_group" "richard_node_group" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "richard-node-group"
  node_role_arn   = aws_iam_role.eks_nodes_role.arn
  subnet_ids      = module.vpc.private_subnets

  instance_types = ["t2.nano"]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  # Ensure the cluster is created before the node group.
  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_container_registry_read_only,
  ]
}