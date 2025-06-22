module "customer1-db" {
  # Path to the module directory
  source = "./modules"

  pg_admin = var.pg_admin
  pg_password = var.pg_password

  # (Optional) Override default names
  database_name          = "employee-app"
  database_user          = "appuser"
  kubernetes_namespace   = "emp-app"

  exoscale_key = var.exoscale_key
  exoscale_secret = var.exoscale_secret
}