# External DNS module
resource "aws_iam_role" "external_dns" {
  name = "${var.cluster_name}-external-dns"

  assume_role_policy = var.oidc_provider_arn != null ? jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Condition = {
          StringEquals = {
            "${var.oidc_issuer}:sub" = "system:serviceaccount:external-dns:external-dns"
            "${var.oidc_issuer}:aud" = "sts.amazonaws.com"
          }
        }
        Principal = {
          Federated = var.oidc_provider_arn
        }
      }
    ]
  }) : jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Add other resources...
