terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.25.2"
    }
  }

  required_version = "~> 1.7.0"
}

data "terraform_remote_state" "kubernetes_cluster" {
  backend = "local"
  config = {
    path = "../cluster/terraform.tfstate"
  }
}

provider "kubernetes" {
  host = data.terraform_remote_state.kubernetes_cluster.outputs.cluster_host

  client_certificate     = data.terraform_remote_state.kubernetes_cluster.outputs.client_certificate
  client_key             = data.terraform_remote_state.kubernetes_cluster.outputs.client_key
  cluster_ca_certificate = data.terraform_remote_state.kubernetes_cluster.outputs.cluster_ca_certificate
}