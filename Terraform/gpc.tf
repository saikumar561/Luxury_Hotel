provider "google" {
credentials = file("C:/Users/ksai9/Downloads/sodium-platform-415013-271c70e10feb.json")
  project     = "sodium-platform-415013"
  region      = "us-central1"
}

resource "google_compute_network" "vpc-luxury" {
 name= "vpc-luxxury" 
 auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet-luxury" {
    network = google_compute_network.vpc-luxury.id
    name= "subnet-luxury"
    ip_cidr_range = "10.0.0.0/24"
  
}
resource "google_compute_global_address" "internal-ip" {
  name          = "global-psconnect-ip"
  address_type  = "INTERNAL"
  purpose       = "VPC_PEERING"
  network       = google_compute_network.vpc-luxury.id
  prefix_length = 16
}
resource "google_project_service" "enable_service_networking_api" {
  project = "sodium-platform-415013"
  service = "servicenetworking.googleapis.com"
}
resource "google_service_networking_connection" "establish-connection" {
  network = google_compute_network.vpc-luxury.id
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.internal-ip.name]
}


resource "google_project_service" "enabling_container_api" {
    service = "container.googleapis.com"
    project = "sodium-platform-415013" 
     disable_on_destroy = false
  
}

resource "google_project_service" "enabling_sql_Api" {
  service = "sqladmin.googleapis.com"
project = "sodium-platform-415013"
}


resource "google_container_cluster" "kubernetes-application" {
   name= "gke-luxury-cluster"
   location = "us-central1"
initial_node_count = 1
enable_autopilot = true
subnetwork = google_compute_subnetwork.subnet-luxury.id
network = google_compute_network.vpc-luxury.id
 node_config {
   oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
labels = {
  environment="production"
  role="frontend"
}
tags = ["production","frontend"]
 }
timeouts {
  create = "50m"
  update = "50m"
}
}


resource "google_sql_database_instance" "MYSQl-1" {
 name = "luxury-sql-instance"
 database_version = "MYSQL_5_7"
 region="us-central1"
  settings {
    tier="db-f1-micro"
    ip_configuration {
      ipv4_enabled = false
      private_network = google_compute_network.vpc-luxury.id
      enable_private_path_for_google_cloud_services = true
    }
  }
}





