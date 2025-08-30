

output "kind_cluster_name" {
  description = "The name of the Kind cluster"
  value       = kind_cluster.default.name
}

output "kubeconfig_path" {
  description = "Path to the Kind cluster kubeconfig"
  value       = kind_cluster.default.kubeconfig_path
}

output "kubeconfig_raw" {
  description = "Raw kubeconfig content"
  value       = kind_cluster.default.kubeconfig
  sensitive   = true
}

output "api_server_url" {
  description = "API server URL for kubectl/helm access"
  value       = "https://127.0.0.1:6443"
}
