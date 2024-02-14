##############################
# Namespace
##############################

resource "kubernetes_namespace_v1" "apps" {
  metadata {
    name = "apps"
    labels = {
      environment = var.environment
    }
  }
}

##############################
# Storage
##############################

resource "kubernetes_persistent_volume_v1" "app_data" {
  metadata {
    name = var.storage_name
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    capacity = {
      storage = var.storage_capacity
    }
    storage_class_name = "standard"
    persistent_volume_source {
      host_path {
        path = "/data"
        type = "DirectoryOrCreate"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim_v1" "app_data_claim" {
  metadata {
    name      = "app-volume-claim"
    namespace = kubernetes_namespace_v1.apps.metadata[0].name
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = var.storage_requests
      }
    }

    volume_name = kubernetes_persistent_volume_v1.app_data.metadata[0].name
  }

}

##############################
# App
##############################

resource "kubernetes_pod_v1" "app" {
  metadata {
    name      = var.app_name
    namespace = kubernetes_namespace_v1.apps.metadata[0].name

    labels = {
      environment              = var.environment
      "app.kubernetes.io/name" = var.app_name
    }
  }

  spec {
    container {
      name  = var.app_name
      image = "nginx:latest"

      resources {
        limits = {
          cpu    = "0.5"
          memory = "128Mi"
        }
        requests = {
          cpu    = "250m"
          memory = "50Mi"
        }
      }

      liveness_probe {
        http_get {
          path = "/"
          port = var.app_port
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "app_service" {
  metadata {
    name      = "${var.app_name}-service"
    namespace = kubernetes_namespace_v1.apps.metadata[0].name
  }

  spec {
    selector = {
      "app.kubernetes.io/name" = var.app_name
    }

    port {
      port        = var.app_port
      target_port = 80
    }

    type = "NodePort"
  }
}

##############################
# Networking
##############################

resource "kubernetes_ingress_v1" "app_ingress" {
  metadata {
    name      = "${var.app_name}-ingress"
    namespace = kubernetes_namespace_v1.apps.metadata[0].name
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/$1"
    }
  }

  spec {
    rule {
      host = "${var.environment}.${var.domain}"
      http {
        path {
          backend {
            service {
              name = kubernetes_service_v1.app_service.metadata[0].name
              port {
                number = kubernetes_service_v1.app_service.spec[0].port[0].target_port
              }
            }
          }

          path = "/app/"
        }
      }
    }
  }
}