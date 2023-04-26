resource "google_project_service" "service" {
  service = "appengineflex.googleapis.com"

  disable_dependent_services = false
}

resource "google_app_engine_flexible_app_version" "myapp_v1" {
  version_id = "v1"
  service    = "service--${local.name_suffix}"
  runtime    = "nodejs"

  entrypoint {
    shell = "node ./app.js"
  }

  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${google_storage_bucket.bucket.name}/${google_storage_bucket_object.object.name}"
    }
  }

  liveness_check {
    path = "/"
  }

  readiness_check {
    path = "/"
  }

  env_variables = {
    port = "8080"
  }

  automatic_scaling {
    cool_down_period = "120s"
    cpu_utilization {
      target_utilization = 0.5
    }
  }

  delete_service_on_destroy = true
}

resource "google_storage_bucket" "bucket" {
  name = "appengine-static-content-${local.name_suffix}"
}

resource "google_storage_bucket_object" "object" {
  name   = "hello-world.zip"
  bucket = google_storage_bucket.bucket.name
  source = "./test-fixtures/appengine/hello-world.zip"
}
