data "google_billing_account" "account" {
}

resource "google_billing_budget" "standard_budget" {
    billing_account = google_billing_account.account
    display_name = "Standard Billing Budget"
    amount {
      specified_amount {
        currency_code = var.billing_budget_currency
        units = var.billing_budget_amount
      }
    }
    dynamic "threshold_rules" {
      for_each = toset([0.25, 0.5, 0.75, 0.9, 1.0])
      threshold_percent = each.key
    }
    depends_on = [
      time_sleep.wait_30_seconds
    ]
}
