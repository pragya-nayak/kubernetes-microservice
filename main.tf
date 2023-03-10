module "gke_cluster" {
  source     = "./modules/terraform-gcp-gke"
  region     = var.region
  project_id = var.project_id
  env        = var.env
}


#############################################################
################### Alerting ################################
#############################################################

resource "google_monitoring_alert_policy" "alert_policy" {
  display_name = "${var.env}-GKE-cpu-utilization-alert"
  combiner     = "OR"
  project      = var.project_id
  conditions {
    display_name = "GKE Container has high CPU limit utilization"
    condition_threshold {
      filter          = "resource.type = \"k8s_container\" AND resource.labels.cluster_name = \"${module.gke_cluster.name}\" AND metric.type = \"kubernetes.io/container/cpu/limit_utilization\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = "75"
      aggregations {
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
      }

    }

  }
  notification_channels = ["projects/gcp-csb-g5/notificationChannels/4768270629932422635"]

}


# resource "google_monitoring_notification_channel" "basic" {
#   display_name = "Test Notification Channel"
#   type         = "email"
#   labels = {
#     email_address = "fake_email@blahblah.com"
#   }
#   force_delete = false
# }

#############################################################
######## Stackdriver Logging ################################
#############################################################
## log view
resource "google_logging_log_view" "primary" {
  name        = "${module.gke_cluster.name}-k8sview"
  bucket      = google_logging_project_bucket_config.basic.id
  description = "A logging view configured with Terraform"
  filter      = "resource.type = \"k8s_cluster\" AND LOG_ID(\"stdout\")"
}

resource "google_logging_project_bucket_config" "basic" {
    project        = var.project_id
    location       = "global"
    retention_days = 30
    bucket_id      = "_Default"
}

# ## bucket
resource "google_storage_bucket" "gke-log-bucket" {
  name          = "${module.gke_cluster.name}-logging-bucket-${random_id.bucket_prefix.hex}"
  storage_class = "NEARLINE"
  location      = "US"
  project       = var.project_id
  force_destroy = true
}

// Create the Stackdriver Export Sink for Cloud Storage GKE Notifications
resource "google_logging_project_sink" "storage-sink" {
  name        = "${module.gke_cluster.name}-gke-storage-sink"
  destination = "storage.googleapis.com/${google_storage_bucket.gke-log-bucket.name}"
  filter      = "resource.labels.cluster_name= \"${module.gke_cluster.name}\" AND resource.type = \"k8s_cluster\""
  project = var.project_id
  unique_writer_identity = true
}

// Grant the role of Storage Object Creator
resource "google_project_iam_binding" "log-writer-storage" {
  role    = "roles/storage.objectCreator"
  project = var.project_id
  members = [
    google_logging_project_sink.storage-sink.writer_identity,
  ]
}

resource "random_id" "bucket_prefix" {
  byte_length = 8
}
