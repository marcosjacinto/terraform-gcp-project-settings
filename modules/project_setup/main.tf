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
  api_list = [
    # Compute and Serverless
    "appengine.googleapis.com",
    "appengineflex.googleapis.com",
    "run.googleapis.com",
    "cloudfunctions.googleapis.com",
    "compute.googleapis.com",
    "apigateway.googleapis.com",
    # Databases and Analytics
    "bigquery.googleapis.com",
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com",
    "pubsub.googleapis.com",
    # Storage
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
    # CI/CD
    "deploymentmanager.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "sourcerepo.googleapis.com",
    # Operations and Others
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "cloudprofiler.googleapis.com",
    "clouddebugger.googleapis.com",
    "cloudtrace.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "cloudscheduler.googleapis.com",
  ]
}

resource "google_project_service" "project_services" {
  for_each = toset(local.api_list)
  project            = var.project_id
  service            = each.key
  disable_on_destroy = true
}

# This is used so there is some time for the activation of the API's to propagate through
# Google Cloud before actually calling them.
resource "time_sleep" "wait_30_seconds" {
  create_duration = "30s"
  depends_on = [
    google_project_service.project_services
  ]
}


resource "google_artifact_registry_repository" "docker_repo" {
  provider      = google-beta
  location      = var.region
  repository_id = var.repository
  description   = "Docker repository"
  format        = "DOCKER"
  depends_on = [
    time_sleep.wait_30_seconds
  ]
}

# Changing permissions from default service accounts

data "google_app_engine_default_service_account" "default" {
  project = var.project_id
  depends_on = [
    time_sleep.wait_30_seconds
  ]
}

data "google_compute_default_service_account" "default" {
  project = var.project_id
  depends_on = [
    time_sleep.wait_30_seconds
  ]
}

data "google_iam_policy" "compute_admin" {
  binding {
    role = "roles/compute.admin"

    members = [
      data.google_compute_default_service_account.default.email
    ]
  }
}

resource "google_project_iam_policy" "project_default_compute_acc" {
  project     = var.project_id
  policy_data = data.google_iam_policy.compute_admin.policy_data
  depends_on = [
    time_sleep.wait_30_seconds
  ]
}

data "google_iam_policy" "app_engine_admin" {
  binding {
    role = "roles/appengine.appAdmin"

    members = [
      data.google_app_engine_default_service_account.default.email
    ]
  }
}

resource "google_project_iam_policy" "project_default_app_engine_acc" {
  project     = var.project_id
  policy_data = data.google_iam_policy.app_engine_admin.policy_data
  depends_on = [
    time_sleep.wait_30_seconds
  ]
}

