# Provider configuration
provider "google" {
  project = var.project_id
  region  = var.region
}

# Enable required APIs
resource "google_project_service" "compute_api" {
  project = var.project_id
  service = "compute.googleapis.com"  # Compute Engine API
}

resource "google_project_service" "iam_api" {
  project = var.project_id
  service = "iam.googleapis.com"  # IAM API
}

resource "google_project_service" "cloudresourcemanager_api" {
  project = var.project_id
  service = "cloudresourcemanager.googleapis.com"  # Resource Manager API
}

# Resource to wait for API enablement
resource "null_resource" "wait_for_api" {
  depends_on = [
    google_project_service.compute_api,
    google_project_service.iam_api,
    google_project_service.cloudresourcemanager_api,
  ]

  provisioner "local-exec" {
    command = "echo 'Waiting for APIs to be enabled...'"
  }
}

# Create a new service account with the name "devops-project"
resource "google_service_account" "devops_service_account" {
  account_id   = "devops-project"  # New service account ID
  display_name = "DevOps Project Service Account"  # Display name
}

# Assign Compute Admin role to the service account
resource "google_project_iam_member" "sa_compute_admin" {
  project = var.project_id
  role    = "roles/compute.admin"
  member  = "serviceAccount:${google_service_account.devops_service_account.email}"
}

# Assign Editor role to the service account
resource "google_project_iam_member" "sa_editor" {
  project = var.project_id
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.devops_service_account.email}"
}

# Create the VM instance using the service account
resource "google_compute_instance" "default" {
  depends_on = [null_resource.wait_for_api]  # Ensure APIs are enabled before creating the instance

  name         = "jenkins-server"
  machine_type = "e2-standard-4"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 20
    }
  }

  network_interface {
    network       = "default"
    access_config {}
  }

  service_account {
    email  = google_service_account.devops_service_account.email  # Use the correct service account reference
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  tags = ["http-server", "https-server"]
}

# Create firewall rule to allow HTTP/HTTPS traffic
resource "google_compute_firewall" "allow_http_https" {
  depends_on = [null_resource.wait_for_api]  # Ensure APIs are enabled before creating the firewall

  name    = "allow-http-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080", "9000", "3001"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server", "https-server"]
}

# Output the external IP of the VM
output "instance_ip" {
  value = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}

