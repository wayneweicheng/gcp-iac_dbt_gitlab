resource "google_storage_bucket" "auto-expire" {
  name          = "wayne_gcp_bucket_iac_${var.branch}_${var.suffix}"
  location      = var.gcp_region
  force_destroy = true
  public_access_prevention = "enforced"
}