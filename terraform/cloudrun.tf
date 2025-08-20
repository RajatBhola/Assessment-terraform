resource "google_project_service" "cloud_run" {
  project = "rajat-assessment-project"
  service = "run.googleapis.com"
}

resource "google_cloud_run_v2_job" "jobs" {
  for_each            = var.cloud_run_jobs
  name                = each.value.name
  location            = var.region
  deletion_protection = false
  depends_on          = [google_project_service.cloud_run]
  template {
    template {
      containers {
        image = each.value.image
        args  = each.value.args
      }
      service_account = google_service_account.cloudrun_sa.email

      volumes {
        name = "cloudsql"
        cloud_sql_instance {
          instances = [google_sql_database_instance.instances["analytics_db"].connection_name]
        }
      }
    }
  }
}
