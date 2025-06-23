variable "exoscale_key" {
  type        = string
  description = "Exoscale API key"
}

variable "exoscale_secret" {
  type        = string
  description = "Exoscale API secret"
  sensitive   = true
}