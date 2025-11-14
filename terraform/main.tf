
# VPC
resource "google_compute_network" "vpc" {
  name                    = "devops-challenge-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "devops-subnet"
  ip_cidr_range = "10.10.0.0/20"
  region        = var.region
  network       = google_compute_network.vpc.id
}


# GKE Cluster
resource "google_container_cluster" "gke" {
  name                     = var.cluster_name
  location                 = var.zone
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.vpc.self_link
  subnetwork               = google_compute_subnetwork.subnet.self_link
  deletion_protection      = false

  addons_config {
    http_load_balancing {
      disabled = false
    }

    horizontal_pod_autoscaling {
      disabled = false
    }
  }
}


# Node Pool
resource "google_container_node_pool" "pool_primary" {
  name       = "primary-pool"
  cluster    = google_container_cluster.gke.name
  location   = var.zone
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    disk_size_gb = 20

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
  }
}


# Executar ansible
resource "null_resource" "ansible_provision" {
  depends_on = [google_container_node_pool.pool_primary]

  provisioner "local-exec" {
    command = var.ansible_command
  }
}
