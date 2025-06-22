resource "kubernetes_secret" "pg_secret" {
  metadata {
    name      = "pg-secret"
    namespace = "default"
  }

  data = {
    username    = var.pg_admin
    password    = var.pg_password
    connection_string = "jdbc:${replace(data.exoscale_database_uri.employee-db.uri, "postgres", "postgresql")}"
    db_host           = data.exoscale_database_uri.employee-db.host
    db_port           = data.exoscale_database_uri.employee-db.port
  }

  type = "Opaque"
}