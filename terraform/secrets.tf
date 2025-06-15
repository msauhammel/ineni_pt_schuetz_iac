resource "kubernetes_secret" "pg_secret" {
  metadata {
    name      = "pg-secret"
    namespace = "default"
  }

  data = {
    admin_username    = var.pg_admin
    admin_password    = var.pg_password
    connection_string = data.exoscale_database_uri.employee-db.uri
  }

  type = "Opaque"
}