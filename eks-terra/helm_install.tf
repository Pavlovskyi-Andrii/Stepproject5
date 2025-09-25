#####################################
# Providers
#####################################
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.this.token
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}

# Получаем токен авторизации к кластеру
data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

#####################################
# Ingress NGINX
#####################################
resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = kubernetes_namespace.ingress_nginx.metadata[0].name
  version    = "4.8.0"

  values = [
    <<-EOF
    controller:
      service:
        type: LoadBalancer
        annotations:
          service.beta.kubernetes.io/aws-load-balancer-type: nlb
          service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled: "true"
      config:
        use-forwarded-headers: "true"
        compute-full-forwarded-for: "true"
    EOF
  ]
}

#####################################
# ArgoCD
#####################################
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  version    = "5.51.0"

  values = [
    <<-EOF
    server:
      service:
        type: ClusterIP
      ingress:
        enabled: true
        ingressClassName: nginx
        hosts:
          - argocd.${var.cluster_short}.${var.group_domain}
        paths:
          - /
        pathType: Prefix
        annotations:
          nginx.ingress.kubernetes.io/ssl-redirect: "false"
          nginx.ingress.kubernetes.io/backend-protocol: "HTTP"
    configs:
      params:
        server.insecure: true
    EOF
  ]

  depends_on = [
    helm_release.ingress_nginx
  ]
}
