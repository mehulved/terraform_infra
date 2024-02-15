terraform {
  required_version = "~> 1.7.0"
}

data "terraform_remote_state" "kubernetes_cluster" {
  backend = "local"
  config = {
    path = "../cluster/terraform.tfstate"
  }
}
