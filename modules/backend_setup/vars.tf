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

variable "location" {
  type = string
  description = "Storage location"
  default = "US"
}

variable "storage_class" {
  type = string
  description = "Storage class"
  default = "STANDARD"
}