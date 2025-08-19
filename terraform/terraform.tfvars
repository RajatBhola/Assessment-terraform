project_id = "rajat-assessment-project"

services = [
  "sqladmin.googleapis.com"
]

service_account = {
  name         = "cloudrun_sa"
  account_id   = "test-sa-cloudrun"
  display_name = "Framework Service Account"
  roles = [
    "roles/run.invoker",
    "roles/storage.admin",
    "roles/cloudsql.admin",
    "roles/artifactregistry.writer"
  ]
}
buckets = {
  test-bucket-rajat = {
    location      = "EUROPE-WEST4"
    force_destroy = true
  }
}

cloud_run_jobs = {
  extract = {
    name  = "extract-data"
    args  = ["python", "src/source/read.py"]
    image = "europe-west4-docker.pkg.dev/rajat-assessment-project/assessment-v2/webshop-analytics:latest"
  }
  transform = {
    name  = "transform-data"
    args  = ["python", "src/transform/main.py"]
    image = "europe-west4-docker.pkg.dev/rajat-assessment-project/assessment-v2/webshop-analytics:latest"
  }
  export = {
    name  = "export-to-table"
    args  = ["python", "src/sink/sqlexport.py"]
    image = "europe-west4-docker.pkg.dev/rajat-assessment-project/assessment-v2/webshop-analytics:latest"
  }
}

cloud_sql_instances = {
  analytics_db = {
    name                = "assessment-v2-1"
    database_version    = "POSTGRES_15"
    tier                = "db-f1-micro"
    ipv4_enabled        = true
    authorized_networks = [{ name = "allow-all", value = "0.0.0.0/0" }]
    deletion_protection = false
  }
}

cloud_sql_databases = {
  webshop_analytics = {
    instance = "assessment-v2-1"
  }
}
