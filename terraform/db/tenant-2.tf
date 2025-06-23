
module "tenant-2-db" {
  # Path to the module directory
  source = "./modules"

  pg_admin = var.pg_admin
  pg_password = var.pg_password

  # (Optional) Override default names
  database_name          = "tenant-2"
  kubernetes_namespace   = "tenant-2"

  exoscale_key    = var.exoscale_key
  exoscale_secret = var.exoscale_secret
}

