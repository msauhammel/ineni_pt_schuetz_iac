terraform {
  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = "0.64.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes" # Kubernetes provider
      version = "2.37.1"               # Specific version
    }
  }
}

provider "kubernetes" {
  config_path = local_sensitive_file.kubeconfig.filename
}

provider "exoscale" {
  secret = var.exoscale_secret
  key    = var.exoscale_key
}

provider "helm" {
  kubernetes {
    config_path = "kubeconfig"
  }
}