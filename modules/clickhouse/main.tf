
resource "kubernetes_namespace" "clickhouse" {
  metadata {
    name = "clickhouse"
  }
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

  create_namespace = false

  values = [
    yamlencode({
      operator = {
        enabled = false
      }

      clickhouse = {
        replicasCount = 3
        shardsCount   = 1
      }

      keeper = {
        enabled      = true
        replicaCount = 3
      }

      persistence = {
        enabled          = true
        storageClassName = "gp3"
        size             = "10Gi"
      }

      users = {
        default = {
          password = "fuko09phsurxho"
        }

        admin = {
          password = "fuko09phsurxho"
          profile  = "default"
          quota    = "default"
          networks = [
            "0.0.0.0/0",
            "::/0"
          ]
        }
      }
    })
  ]

  depends_on = [
    helm_release.clickhouse_operator
  ]

  timeout = 900
  wait    = true
}
