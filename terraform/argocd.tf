locals {
  repo_url      = "https://github.com/msauhammel/ineni_pt_schuetz_iac"
  repo_path     = "gitops-base"
  app_name      = "gitops-base"
  app_namespace = "argocd"
}

resource "helm_release" "argo_cd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "8.0.0"
  timeout          = 1200
  create_namespace = true
  namespace        = "argocd"
  lint             = true
  wait             = true

  values = [
    templatefile("app-values.yaml", {
      repo_url      = local.repo_url
      repo_path     = local.repo_path
      app_name      = local.app_name
      app_namespace = local.app_namespace
    })
  ]

  depends_on = [
    exoscale_sks_nodepool.default
  ]
}