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

variable "repository" {
  description = "Artifact Registry repository's name"
  type        = string
  default     = "docker-repository"
}

variable "billing_budget_amount" {
  description = "Project's maximum budget"
  type = string
  default = "500"
}

variable "billing_budget_currency" {
  description = "Project's maximum currency"
  type = string
  default = "BRL"
}

variable "billing_account_name" {
  description = "Billing account display name"
  type = string
}