output "cluster_name" {
  value = minikube_cluster.cluster.cluster_name
}

output "cluster_host" {
  value = minikube_cluster.cluster.host
}

output "client_certificate" {
  value     = minikube_cluster.cluster.client_certificate
  sensitive = true
}

output "client_key" {
  value     = minikube_cluster.cluster.client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = minikube_cluster.cluster.cluster_ca_certificate
  sensitive = true
}