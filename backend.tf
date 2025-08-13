terraform {
  backend "gcs" {
    bucket = "assessment-terraform"
    prefix = "infra/state"
  }
}
