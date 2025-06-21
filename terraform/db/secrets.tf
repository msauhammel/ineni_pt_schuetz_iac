resource "kubernetes_namespace" "emp_app" {
  metadata {
    name = "emp-app"
  }
}

resource "kubernetes_secret" "pg_secret" {
  metadata {
    name      = "pg-secret"
    namespace = "emp-app"
  }

  data = {
    admin_username    = var.pg_admin
    admin_password    = var.pg_password
    connection_string = data.exoscale_database_uri.employee-db.uri
    db_host           = data.exoscale_database_uri.employee-db.host
    db_port           = data.exoscale_database_uri.employee-db.port
  }

  type = "Opaque"
}