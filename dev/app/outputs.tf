output "app_storage_path" {
  value = kubernetes_persistent_volume_v1.app_data.spec[0].persistent_volume_source[0].host_path[0].path
}

output "app_url" {
  value = "${data.terraform_remote_state.kubernetes_cluster.outputs.cluster_host}${kubernetes_ingress_v1.app_ingress.spec[0].rule[0].http[0].path[0].path}"
}

output "app_environment" {
  value = kubernetes_pod_v1.app.metadata[0].labels.environment
}