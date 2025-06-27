
module "tenant-9-db" {
  # Path to the module directory
  source = "./modules"

  pg_admin = var.pg_admin
  pg_password = var.pg_password

  # (Optional) Override default names
  database_name          = "tenant-9"
  kubernetes_namespace   = "tenant-9"

  exoscale_key    = var.exoscale_key
  exoscale_secret = var.exoscale_secret
}

