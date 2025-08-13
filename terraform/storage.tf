resource "google_storage_bucket" "buckets" {
  for_each                    = var.buckets
  name                        = each.key
  location                    = each.value.location
  force_destroy               = each.value.force_destroy
  uniform_bucket_level_access = true
}
