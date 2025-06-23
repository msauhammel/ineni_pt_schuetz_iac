variable "exoscale_key" {
  type        = string
  description = "Exoscale API key"
}

variable "exoscale_secret" {
  type        = string
  description = "Exoscale API secret"
  sensitive   = true
}

variable "exoscale_zone" {
  type        = string
  description = "Exoscale zone to use"
  default     = "at-vie-2"
}

variable "database_name" {
  description = "PostgreSQL Databasename"
  type        = string
  default = "employee-db"
}

variable "database_user" {
  type        = string
  description = "The username for the new PostgreSQL user."
  default     = "appuser"
}

variable "kubernetes_namespace" {
  type        = string
  description = "The Kubernetes namespace where the secret will be created."
  default     = "default"
}

variable "pg_admin" {
  description = "Admin username for PostgreSQL"
  type        = string
  default     = "admin"
}

variable "pg_password" {
  description = "Admin password for PostgreSQL"
  type        = string
}