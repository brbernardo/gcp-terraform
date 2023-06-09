resource "google_vertex_ai_featurestore" "featurestore" {
  name     = "terraform-${local.name_suffix}"
  labels = {
    foo = "bar"
  }
  region   = "us-central1"
  online_serving_config {
    fixed_node_count = 2
  }
}

resource "google_vertex_ai_featurestore_entitytype" "entity" {
  name     = "terraform-${local.name_suffix}"
  labels = {
    foo = "bar"
  }
  featurestore = google_vertex_ai_featurestore.featurestore.id
}

resource "google_vertex_ai_featurestore_entitytype_feature" "feature" {
  name     = "terraform-${local.name_suffix}"
  labels = {
    foo = "bar"
  }
  entitytype = google_vertex_ai_featurestore_entitytype.entity.id

  value_type = "INT64_ARRAY"
}
