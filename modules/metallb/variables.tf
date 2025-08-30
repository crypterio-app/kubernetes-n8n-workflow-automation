
variable "kind_cluster_config_path" {
  type        = string
  description = "The location where this cluster's kubeconfig will be saved to."
  default     = "~/.kube/config"
}

variable "metallb_ip_range" {
  description = "The kind version of kubernetes."
  default     = "172.18.255.1-172.18.255.250"
  type        = string
}
