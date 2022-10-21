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

locals {
  iam_apis = [
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
  ]
}

resource "google_project_service" "iam_apis" {
  for_each           = toset(local.iam_apis)
  project            = var.project_id
  service            = each.key
  disable_on_destroy = false
}

resource "time_sleep" "wait_30_seconds" {
  create_duration = "30s"
  depends_on = [
    google_project_service.iam_apis
  ]
}

resource "google_service_account" "terraform" {
  provider     = google-beta
  account_id   = "terraform-${var.project_id}"
  display_name = "Terraform service account"
  depends_on = [
    time_sleep.wait_30_seconds
  ]
}

resource "google_project_iam_member" "permissions" {
  for_each = toset(var.permissions)
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.terraform.email}"
}

resource "google_billing_account_iam_member" "editor" {
  billing_account_id = var.billing_account_id
  role               = "roles/billing.costsManager"
  member             = "serviceAccount:${google_service_account.terraform.email}"
}
