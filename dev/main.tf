terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.39.0"
    }
  }
  backend "gcs" {
    bucket = "${GCP_PROJECT_ID}-terraform"
    prefix = "terraform/state"
  }
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "gcp_settings" {
  source = "../modules/project_setup"
  project_id = var.project_id
  region = var.region
  zone = var.zone
}
