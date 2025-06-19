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

variable "pg_admin" {
  description = "Admin username for PostgreSQL"
  type        = string
  default     = "admin"

}

variable "pg_password" {
  description = "Amin password for PostgreSQL"
  type        = string
}