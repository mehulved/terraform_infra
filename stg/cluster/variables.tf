variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
  default     = "stg-cluster"
}

variable "cluster_addons" {
  description = "List of addons for the cluster"
  type        = list(string)
  default = [
    "default-storageclass",
    "storage-provisioner",
    "dashboard",
    "ingress",
  ]
}

