output "cluster_name" {
  value       = google_container_cluster.gke.name
  description = "Cluster name"
}

output "cluster_endpoint" {
  value       = google_container_cluster.gke.endpoint
  description = "GKE API endpoint"
}

output "node_pool_name" {
  value       = google_container_node_pool.pool_primary.name
  description = "Node pool name"
}
