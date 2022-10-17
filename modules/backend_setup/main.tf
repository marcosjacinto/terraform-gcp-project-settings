terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.39.0"
    }
  }
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}


resource "google_project_service" "storage_api" {
  project            = var.project_id
  service            = "storage-api.googleapis.com"
  disable_on_destroy = true
}


resource "time_sleep" "wait_30_seconds" {
  create_duration = "30s"
  depends_on = [
    google_project_service.storage_api
  ]
}

resource "google_storage_bucket" "terraform-backend" {
  name          = "${var.project_id}-terraform"
  location      = var.location
  force_destroy = true
  storage_class = var.storage_class
  versioning {
    enabled = true
  }
  depends_on = [
    time_sleep.wait_30_seconds
  ]
}