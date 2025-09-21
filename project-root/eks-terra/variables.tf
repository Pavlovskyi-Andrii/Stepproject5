variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}


variable "cluster_name" {
  type    = string
  default = "student1-cluster"
}


variable "node_instance_type" {
  type    = string
  default = "t3.micro"
}


variable "node_desired_capacity" {
  type    = number
  default = 1
}
