

variable "kind_cluster_name" {
  description = "The name of the Kind cluster"
  type        = string
}

variable "kind_cluster_config_path" {
  description = "Path to save the Kind kubeconfig file"
  type        = string
}

variable "charts_path" {
  default     = "./charts"
  description = "The charts full path"
}

variable "k8s_version" {
  description = "Kubernetes version to use for Kind nodes"
  type        = string
}

variable "worker_count" {
  description = "Number of worker nodes"
  type        = number
}

variable "additional_control_planes_count" {
  description = "Number of additional control planes for HA"
  type        = number
  default     = 2
}
