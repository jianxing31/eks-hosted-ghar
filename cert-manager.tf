resource "helm_release" "cert_manager" {
  namespace        = "cert-manager"
  create_namespace = true
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.10.0"

  set {
    name  = "installCRDs"
    value = true
  }
}


locals {
  arc_namespace        = "actions-runner-system"
  arc_release          = "actions-runner-controller"
  arc_chart_repository = "https://actions-runner-controller.github.io/actions-runner-controller"
  arc_chart            = "actions-runner-controller"
  arc_chart_version    = "0.23.2"
}


resource "helm_release" "arc" {
  namespace        = local.arc_namespace
  create_namespace = true

  name       = local.arc_release
  repository = local.arc_chart_repository
  chart      = local.arc_chart

  version = local.arc_chart_version

  set {
    name  = "authSecret.create"
    value = true
  }

  set_sensitive {
    name  = "authSecret.github_token"
    value = var.pat_token
  }

  depends_on = [
    helm_release.cert_manager
  ]
}
