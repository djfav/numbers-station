terraform {
  # https://www.terraform.io/language/providers/requirements
  required_providers {
    betteruptime = {
      source  = "BetterStackHQ/better-uptime"
      version = "~> 0.3.0"
    }
  }
}

# https://registry.terraform.io/providers/BetterStackHQ/better-uptime/latest/docs/resources/betteruptime_heartbeat
resource "betteruptime_heartbeat" "heartbeat" {
  name   = var.betteruptime_subdomain
  period = 3600
  grace  = 300
  email  = true
  paused = false
}

# https://registry.terraform.io/providers/BetterStackHQ/better-uptime/latest/docs/resources/betteruptime_status_page
resource "betteruptime_status_page" "status_page" {
  company_name = var.betteruptime_subdomain
  company_url  = var.twitter_url
  subdomain    = var.betteruptime_subdomain
  timezone     = "Central Time (US & Canada)"
}

# https://registry.terraform.io/providers/BetterStackHQ/better-uptime/latest/docs/resources/betteruptime_status_page_resource
resource "betteruptime_status_page_resource" "status_page_resource" {
  public_name    = var.betteruptime_subdomain
  resource_id    = betteruptime_heartbeat.heartbeat.id
  resource_type  = "Heartbeat"
  status_page_id = betteruptime_status_page.status_page.id
  history        = true
}