terraform {
  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = "0.3.10"
    }
  }

  required_version = "~> 1.7.0"
}

provider "minikube" {
  kubernetes_version = "v1.28.3"
}