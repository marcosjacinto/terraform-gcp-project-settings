variable "project_id" {
  description = "Project name"
  type        = string
  default = "$GCP_PROJECT_ID"
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