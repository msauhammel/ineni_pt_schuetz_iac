resource "exoscale_dbaas" "pg" {
  name = var.database_name
  type = "pg"
  zone = var.exoscale_zone
  plan = "hobbyist-2"

  termination_protection = false

  pg {
    version   = "15"
    ip_filter = ["0.0.0.0/0"]

    pg_settings = jsonencode({
      timezone : "Europe/Vienna"
    })

    admin_username = var.pg_admin
    admin_password = var.pg_password
  }
}

resource "exoscale_dbaas_pg_database" "employee-db" {
  # Creates a PostgreSQL database named "employee-db" in the above service
  database_name = var.database_name
  service       = exoscale_dbaas.pg.name
  zone          = exoscale_dbaas.pg.zone
}

resource "exoscale_dbaas_pg_user" "appuser" {
  # Creates a PostgreSQL user named "appuser" with access to the service
  username = "appuser"
  service  = exoscale_dbaas.pg.name
  zone     = exoscale_dbaas.pg.zone
}

data "exoscale_database_uri" "employee-db" {
  name = var.database_name
  type = "pg"
  zone = exoscale_dbaas.pg.zone
  depends_on = [
    exoscale_dbaas_pg_database.employee-db,
    exoscale_dbaas_pg_user.appuser
  ]
}

provider "postgresql" {
  host            = data.exoscale_database_uri.employee-db.host
  port            = data.exoscale_database_uri.employee-db.port
  username        = var.pg_admin
  password        = var.pg_password
  database        = var.database_name
  sslmode         = "require"
}

resource "postgresql_grant" "schema_usage" {
  database    = "defaultdb"
  role        = exoscale_dbaas_pg_user.appuser.username
  schema      = "public"
  object_type = "schema"
  privileges  = ["USAGE", "CREATE"]

  depends_on = [data.exoscale_database_uri.employee-db]
}


resource "kubernetes_namespace" "tenant_namespace" {
  metadata {
    name = var.kubernetes_namespace
  }
}

output "exoscale_database_uri" {
  value     = data.exoscale_database_uri.employee-db.uri
  sensitive = true
}