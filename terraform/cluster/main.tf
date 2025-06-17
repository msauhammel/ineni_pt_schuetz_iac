resource "exoscale_sks_cluster" "employee_app" {
  name          = "employee_app"
  zone          = var.exoscale_zone
  service_level = var.sks_service_level
}

resource "exoscale_sks_nodepool" "default" {
  cluster_id    = exoscale_sks_cluster.employee_app.id
  name          = "default-pool"
  zone          = exoscale_sks_cluster.employee_app.zone
  instance_type = "standard.medium"
  size          = 1
  security_group_ids = [
    exoscale_security_group.employee_app_security_group.id
  ]
}

resource "exoscale_sks_kubeconfig" "employee_app_kubeconfig" {
  cluster_id = exoscale_sks_cluster.employee_app.id
  zone       = exoscale_sks_cluster.employee_app.zone

  user   = "kubernetes-admin"
  groups = ["system:masters"]
}

resource "local_sensitive_file" "kubeconfig" {
  filename = "../kubeconfig"
  content  = exoscale_sks_kubeconfig.employee_app_kubeconfig.kubeconfig
  file_permission = "0600"
}

output "sks_cluster_endpoint" {
  value = exoscale_sks_cluster.employee_app.endpoint
}