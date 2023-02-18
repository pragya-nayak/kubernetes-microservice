module "gke" {
  source     = "./modules/terraform-gke-bkup"
  region     = var.region
  project_id = var.project_id
  #    network = "default"  #data.google_compute_network.network
  #    subnetwork = "default" #data.google_compute_subnetwork.subnetwork
}

# module "networking" {
#     source = "./modules/terraform-gcp-networking"
#     region = var.region
#     project_id = var.project_id
# }

# resource "null_resource" "execfile" {
#   provisioner "local-exec" {
#     command = file("${path.module}/microservice.sh")
#     # interpreter = ["/bin/bash"]
#   }
# }

# data "google_compute_network" "network" {
#   name    = "default"
#   region  = var.region
#   project = var.project_id
# }

# data "google_compute_subnetwork" "subnetwork" {
#   name    = "default"
#   region  = var.region
#   project = var.project_id

# }

# output "network" {
#   value = data.google_compute_network.name
# }

# output "subnetwork" {
#   value = data.google_compute_subnetwork.name
# }
