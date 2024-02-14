##############################
# Cluster
##############################

resource "minikube_cluster" "cluster" {
  driver       = "docker"
  cluster_name = var.cluster_name
  addons       = var.cluster_addons
}
