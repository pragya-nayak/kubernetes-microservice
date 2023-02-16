
resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "state" {
  name          = "${random_id.bucket_prefix.hex}-bucket-tfstate"
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
  project       = "gcp-csb-g5"
  versioning {
    enabled = true
  }
}

output "bucket_name" {
  value       = google_storage_bucket.state.name
  description = "Cloud Storage Bucket Name"
}

