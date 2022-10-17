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

variable "repository" {
  description = "Artifact Registry repository's name"
  type        = string
  default     = "docker-repository"
}