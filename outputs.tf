# output "region" {
#   value       = module.gke.region
#   description = "GCloud Region"
# }

# output "project_id" {
#   value       = module.gke.project_id
#   description = "GCloud Project ID"
# }

# output "kubernetes_cluster_name" {
#   value       = module.gke.kubernetes_cluster_name
#   description = "GKE Cluster Name"
# }

output "cluster_name" {
  value       = module.gke_cluster.name
  description = "GKE Cluster Host"
}
