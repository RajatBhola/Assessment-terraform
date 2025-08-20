resource "google_project_service" "cloudresourcemanager" {
  project = var.project_id
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "iam_api" {
  project = var.project_id
  service = "iam.googleapis.com"

  disable_on_destroy = false
}

resource "google_service_account" "cloudrun_sa" {
  account_id   = var.service_account.account_id
  display_name = var.service_account.display_name
}

resource "google_project_iam_member" "service_account_roles" {
  for_each = toset(var.service_account.roles)

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.cloudrun_sa.email}"
}
