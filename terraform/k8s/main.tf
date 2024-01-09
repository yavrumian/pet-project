resource "helm_release" "csi-secrets-store" {
  name         = "secrets-store-csi-driver"
  namespace    = "kube-system"
  version      = "1.4.0"
  chart        = "secrets-store-csi-driver"
  repository   = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  force_update = false
}

resource "helm_release" "secrets-store-csi-driver-provider-aws" {
  name         = "secrets-store-csi-driver-aws"
  namespace    = "kube-system"
  chart        = "secrets-store-csi-driver-provider-aws"
  repository   = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
  force_update = false
}

resource "helm_release" "keda" {
  create_namespace = true
  name             = "keda"
  namespace        = "keda"
  version          = "2.12.1"
  chart            = "keda"
  repository       = "https://kedacore.github.io/charts"
  force_update     = false
}

resource "helm_release" "metrics-server" {
  name         = "metrics-server"
  namespace    = "kube-system"
  version      = "3.11.0"
  chart        = "metrics-server"
  repository   = "https://kubernetes-sigs.github.io/metrics-server/"
  force_update = false
}

resource "helm_release" "ingress-nginx" {
  name             = "ingress-nginx"
  namespace        = "ingress-nginx"
  version          = "4.7.1"
  chart            = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  force_update     = false
  create_namespace = true

  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }
}

resource "kubernetes_namespace" "core" {
  metadata {
    name = var.environment
  }
}
