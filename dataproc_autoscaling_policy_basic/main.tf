resource "google_dataproc_autoscaling_policy" "basic" {
  policy_id = "dataproc-policy-${local.name_suffix}"
  location  = "us-central1"

  worker_config {
    max_instances = 3
  }

  basic_algorithm {
    yarn_config {
      graceful_decommission_timeout = "30s"

      scale_up_factor   = 0.5
      scale_down_factor = 0.5
    }
  }
}
