resource "google_compute_snapshot" "snapshot" {
  name        = "my-snapshot-${local.name_suffix}"
  source_disk = google_compute_disk.persistent.id
  zone        = "us-central1-a"
  labels = {
    my_label = "value"
  }
  storage_locations = ["us-central1"]
}

data "google_compute_image" "debian" {
  family  = "debian-11"
  project = "debian-cloud"
}

resource "google_compute_disk" "persistent" {
  name  = "debian-disk-${local.name_suffix}"
  image = data.google_compute_image.debian.self_link
  size  = 10
  type  = "pd-ssd"
  zone  = "us-central1-a"
}
