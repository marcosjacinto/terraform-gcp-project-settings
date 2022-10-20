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
