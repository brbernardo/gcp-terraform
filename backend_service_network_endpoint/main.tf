resource "google_compute_global_network_endpoint_group" "external_proxy" {
  provider = google-beta
  name                  = "network-endpoint-${local.name_suffix}"
  network_endpoint_type = "INTERNET_FQDN_PORT"
  default_port          = "443"
}

resource "google_compute_global_network_endpoint" "proxy" {
  provider = google-beta
  global_network_endpoint_group = google_compute_global_network_endpoint_group.external_proxy.id
  fqdn                          = "test.example.com"
  port                          = google_compute_global_network_endpoint_group.external_proxy.default_port
}

resource "google_compute_backend_service" "default" {
  provider = google-beta
  name                            = "backend-service-${local.name_suffix}"
  enable_cdn                      = true
  timeout_sec                     = 10
  connection_draining_timeout_sec = 10

  custom_request_headers          = ["host: ${google_compute_global_network_endpoint.proxy.fqdn}"]
  custom_response_headers         = ["X-Cache-Hit: {cdn_cache_status}"]

  backend {
    group = google_compute_global_network_endpoint_group.external_proxy.id
  }
}
