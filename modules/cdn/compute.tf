
resource "google_compute_backend_bucket" "default" {
  name        = "evilcorp-backend"
  description = "evilcorp cdn"
  bucket_name = google_storage_bucket.default.name
  enable_cdn  = true
}
resource "google_compute_global_address" "default" {
  name       = "evicorp-cdn-address"
  ip_version = "IPV4"
}

resource "google_compute_url_map" "cdn_url_map" {
  name            = "cdn-url-map"
  description     = "CDN URL map to cdn_backend_bucket"
  default_service = google_compute_backend_bucket.default.self_link


}

resource "google_compute_global_forwarding_rule" "http" {
  name       = "evil-corp-cdn-http"
  target     = google_compute_target_http_proxy.http_proxy.self_link
  ip_address = google_compute_global_address.default.address
  port_range = "80"
  depends_on = [google_compute_global_address.default]
}


resource "google_compute_target_http_proxy" "http_proxy" {
 name = "evilcopr-http-proxy" 
 url_map = google_compute_url_map.cdn_url_map.id
}


