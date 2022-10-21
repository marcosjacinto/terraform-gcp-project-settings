variable "project_id" {
  description = "Project name"
  type        = string
}

variable "region" {
  description = "Default compute region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Default compute zone"
  type        = string
  default     = "us-central1-a"
}

variable "permissions" {
  description = "List of permissions"
  type = list
  default = [
    "roles/editor",
    "roles/artifactregistry.admin",
    "roles/run.admin",
    "roles/resourcemanager.projectIamAdmin",
    "roles/iam.serviceAccountUser",
    "roles/serviceusage.serviceUsageAdmin",
    "roles/storage.admin",
  ]
}

variable "billing_account_id" {
  description = "Billing account ID"
  type = string
}
