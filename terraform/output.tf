output "bucket_names" {
  value = [for b in google_storage_bucket.buckets : b.name]
}

output "cloud_run_job_names" {
  value = [for j in google_cloud_run_v2_job.jobs : j.name]
}

output "cloud_sql_instance_names" {
  value = [for i in google_sql_database_instance.instances : i.name]
}
