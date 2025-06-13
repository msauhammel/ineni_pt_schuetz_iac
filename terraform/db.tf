resource "exoscale_dbaas" "pg" {
  name = "employee-db"
  type = "pg"
  zone = exoscale_sks_cluster.employee_app.zone
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
  database_name = "employee-db"
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
  name = "employee-db"
  type = "pg"
  zone = exoscale_dbaas.pg.zone
}

output "exoscale_database_uri" {
  value     = data.exoscale_database_uri.employee-db.uri
  sensitive = true
}