module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.27"
  subnets         = data.aws_subnets.default.ids


  node_groups = {
    student_nodes = {
      desired_capacity = var.node_desired_capacity
      max_capacity     = 1
      min_capacity     = 1
      instance_types   = [var.node_instance_type]
    }
  }
}


data "aws_vpc" "default" {
  default = true
}
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
