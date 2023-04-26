resource "google_notebooks_runtime" "runtime_container" {
  name = "notebooks-runtime-kernel-${local.name_suffix}"
  location = "us-central1"
  access_config {
    access_type = "SINGLE_USER"
    runtime_owner = "admin@hashicorptest.com"
  }
  software_config {
    kernels {
      repository = "gcr.io/deeplearning-platform-release/base-cpu"
      tag        = "latest"
    }
  }
  virtual_machine {
    virtual_machine_config {
      machine_type = "n1-standard-4"
      data_disk {
        initialize_params {
          disk_size_gb = "100"
          disk_type = "PD_STANDARD"
        }
      }
    }
  }
}
