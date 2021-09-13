resource "google_storage_bucket" "default" {
  name                        = "evilcorp-cdn-bucket"
  location                    = var.region
  uniform_bucket_level_access = true
  storage_class               = "REGIONAL"
  force_destroy               = true
}

resource "google_storage_bucket_iam_member" "all_users_viewers" {
  bucket = google_storage_bucket.default.name
  role   = "roles/storage.legacyObjectReader"
  member = "allUsers"
}

