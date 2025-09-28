# IAM role for External DNS
resource "aws_iam_role" "external_dns" {
  name = "${var.cluster_name}-external-dns"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Condition = {
          StringEquals = {
            "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub" = "system:serviceaccount:external-dns:external-dns"
            "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:aud" = "sts.amazonaws.com"
          }
        }
        Principal = {
          Federated = module.eks.oidc_provider_arn
        }
      }
    ]
  })
}

# IAM policy for External DNS
resource "aws_iam_role_policy" "external_dns" {
  name = "${var.cluster_name}-external-dns-policy"
  role = aws_iam_role.external_dns.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "route53:ChangeResourceRecordSets"
        ]
        Resource = [
          "arn:aws:route53:::hostedzone/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets"
        ]
        Resource = [
          "*"
        ]
      }
    ]
  })
}

# External DNS Helm chart
resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"
  namespace  = "external-dns"
  version    = "1.13.1"

  create_namespace = true

  values = [
    yamlencode({
      serviceAccount = {
        create = true
        annotations = {
          "eks.amazonaws.com/role-arn" = aws_iam_role.external_dns.arn
        }
      }
      provider = "aws"
      aws = {
        region = var.aws_region
      }
      domainFilters = [var.domain_name]
      policy = "sync"
      txtOwnerId = var.cluster_name
    })
  ]

  depends_on = [module.eks]
}
