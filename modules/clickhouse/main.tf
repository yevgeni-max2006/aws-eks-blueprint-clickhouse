
resource "kubernetes_namespace" "clickhouse" {
  metadata {
    name = "clickhouse"
  }
}


resource "kubernetes_secret_v1" "clickhouse_credentials" {
  metadata {
    name      = "clickhouse-credentials"
    namespace = kubernetes_namespace.clickhouse.metadata[0].name
  }

  data = {
    user     = "default"
    password = "fuko09phsurxho"
  }

  type = "Opaque"
}


resource "helm_release" "clickhouse_operator" {
  name       = "clickhouse-operator"
  repository = "https://helm.altinity.com"
  chart      = "altinity-clickhouse-operator"
  namespace  = kubernetes_namespace.clickhouse.metadata[0].name

  create_namespace = false

  timeout = 600
  wait    = true
}


resource "helm_release" "clickhouse" {
  name       = "clickhouse"
  repository = "https://helm.altinity.com"
  chart      = "clickhouse"
  namespace  = kubernetes_namespace.clickhouse.metadata[0].name

  values = [
    yamlencode({
      clickhouse = {
        replicasCount = 3
        shardsCount   = 1
      }

      keeper = {
        enabled      = true
        replicaCount = 3
      }

      users = {
        default = {
          password = "fuko09phsurxho"
        }
      }

      persistence = {
        enabled          = true
        storageClassName = "gp3"
        size             = "10Gi"
      }
    })
  ]

  depends_on = [
    helm_release.clickhouse_operator,
    kubernetes_secret_v1.clickhouse_credentials
  ]

  timeout = 900
  wait    = true
}
