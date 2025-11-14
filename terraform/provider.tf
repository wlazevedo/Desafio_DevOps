provider "google" {
  project = var.project_id
  region  = var.region
  # zone is used directly in resources where needed
}
