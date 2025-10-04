# VPC модуль
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "< 6.0.0"

  name = "${var.cluster_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = data.aws_availability_zones.available.names
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Project     = "devops-final"
  }
}

# EKS модуль
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  # Новый способ добавления прав администратора
  enable_cluster_creator_admin_permissions = true

  # Аддоны EKS
  cluster_addons = {
    coredns = {
    most_recent = true
    configuration_values = jsonencode({
      resources = {
        limits = {
          cpu    = "200m"
          memory = "256Mi"
        }
        requests = {
          cpu    = "100m"
          memory = "128Mi"
        }
      }
      replicaCount = 3  # увеличить количество реплик
    })
  }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  # Управляемые групповые узлы EKS
  eks_managed_node_groups = {
    main = {
      min_size       = 3
      max_size       = 6
      desired_size   = 4
      instance_types = ["t2.small"] #["t3.medium"]
      capacity_type  = "ON_DEMAND"


      ami_type = "AL2023_x86_64_STANDARD"

      labels = {
        Environment = "dev"
        NodeGroup   = "main"
      }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
    Project     = "devops-final"
  }
}

# Данные
data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_eks_cluster" "this" {
  name = module.eks.cluster_name
}





