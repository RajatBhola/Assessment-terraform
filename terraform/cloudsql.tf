resource "google_sql_database_instance" "instances" {
  for_each         = var.cloud_sql_instances
  name             = each.value.name
  region           = var.region
  database_version = each.value.database_version

  settings {
    tier = each.value.tier

    ip_configuration {
      ipv4_enabled = each.value.ipv4_enabled

      dynamic "authorized_networks" {
        for_each = each.value.authorized_networks
        content {
          name  = authorized_networks.value.name
          value = authorized_networks.value.value
        }
      }
    }
  }

  depends_on = [google_project_service.enabled_services]
}


resource "google_sql_database" "databases" {
  for_each = var.cloud_sql_databases
  name     = each.key
  instance = each.value.instance
  depends_on = [google_project_iam_member]
}
