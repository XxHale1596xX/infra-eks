resource "kubernetes_deployment" "g2-3soat-app" {
  metadata {
    name = "g2-3soat-app"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "g2-3soat-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "g2-3soat-app"
        }
      }

      spec {
        container {
          image = "992382631789.dkr.ecr.us-east-1.amazonaws.com/g2-3soat:latest"
          name  = "g2-3soat-app"
          port {
            container_port = 3000
          }

          liveness_probe {
            http_get {
              path   = "/products"
              port   = 3000
              scheme = "HTTP"
            }
            initial_delay_seconds = 10
            period_seconds        = 3
          }
        }
      }
    }
  }

}

resource "kubernetes_service" "Load_Balancer" {
  metadata {
    name = "load-balancer-g2-3soat"
  }

  spec {
    selector = {
      app = "g2-3soat-app"
    }
    port {
      port        = 3000
      target_port = 3000
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_horizontal_pod_autoscaler_v1" "EKS_hpa" {
  metadata {
    name      = "g2-3soat-hpa"
    namespace = "default"
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "g2-3soat-deployment"
    }

    min_replicas = 1
    max_replicas = 5

    target_cpu_utilization_percentage = 30
  }
}

data "kubernetes_service" "dns-g2-3soat" {
  metadata {
    name = "load-balancer-g2-3soat"
  }
}

output "URL" {
  value = data.kubernetes_service.dns-g2-3soat.status
}