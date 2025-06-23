resource "kubernetes_secret" "pg_secret" {
  metadata {
    name      = "pg-secret"
    namespace = var.kubernetes_namespace
  }

  data = {
    username    = exoscale_dbaas_pg_user.appuser.username
    password    = exoscale_dbaas_pg_user.appuser.password
    connection_string = "jdbc:postgresql://${data.exoscale_database_uri.employee-db.host}:${data.exoscale_database_uri.employee-db.port}/defaultdb"
    db_host           = data.exoscale_database_uri.employee-db.host
    db_port           = data.exoscale_database_uri.employee-db.port
  }

  type = "Opaque"

  depends_on = [
    exoscale_dbaas_pg_database.employee-db
  ]
}