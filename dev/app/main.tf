module "app" {
  source = "git@github.com:mehulved/terraform_modules.git//kubernetes_app?ref=v1.0.0"

  client_certificate     = data.terraform_remote_state.kubernetes_cluster.outputs.client_certificate
  client_key             = data.terraform_remote_state.kubernetes_cluster.outputs.client_key
  cluster_ca_certificate = data.terraform_remote_state.kubernetes_cluster.outputs.cluster_ca_certificate
  cluster_host           = data.terraform_remote_state.kubernetes_cluster.outputs.cluster_host

  environment = var.environment
  app_name    = var.app_name
  domain      = var.domain
  namespace   = var.namespace
}