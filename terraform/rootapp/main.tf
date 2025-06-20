terraform {
  backend "s3" {
    bucket                      = "inenp-state"
    key                         = "terraform.tfstate"
    endpoint                    = "https://sos-at-vie-2.exo.io"
    region                      = "at-vie-2"
    force_path_style            = true
    skip_region_validation      = true
    skip_credentials_validation = true
  }
  
  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = "0.64.1"
    }
    helm = {
      source  = "hashicorp/helm" # Helm chart provider
      version = "2.12.1"         # Specific version
    }
    kubernetes = {
      source  = "hashicorp/kubernetes" # Kubernetes provider
      version = "2.37.1"               # Specific version
    }
  }
}

provider "exoscale" {
  secret = var.exoscale_secret
  key    = var.exoscale_key
}

provider "kubernetes" {
  config_path = "../kubeconfig"
}

resource "kubernetes_manifest" "argocd_root_app" {
  manifest = yamldecode(file("../../gitops-base/root-app.yaml"))
}