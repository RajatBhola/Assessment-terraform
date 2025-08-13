variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "europe-west4"
}

variable "zone" {
  type    = string
  default = "europe-west4-c"
}

variable "services" {
  description = "Google Cloud APIs to enable"
  type        = list(string)
}

variable "service_account" {
  description = "Map defining the service account and its roles"
  type = object({
    account_id   = string
    display_name = string
    roles        = list(string)
  })
}

variable "buckets" {
  description = "Map of GCS buckets"
  type = map(object({
    location      = string
    force_destroy = bool
  }))
}

variable "cloud_run_jobs" {
  description = "Map of Cloud Run jobs"
  type = map(object({
    name  = string
    args  = list(string)
    image = string
  }))
}

variable "cloud_sql_instances" {
  description = "Map of Cloud SQL instances"
  type = map(object({
    name                = string
    database_version    = string
    tier                = string
    ipv4_enabled        = bool
    authorized_networks = list(object({ name = string, value = string }))
    deletion_protection = bool
  }))
}

variable "cloud_sql_users" {
  description = "Map of Cloud SQL users"
  type = map(object({
    instance = string
    password = string
  }))
}

variable "cloud_sql_databases" {
  description = "Map of Cloud SQL databases"
  type = map(object({
    instance = string
  }))
}
