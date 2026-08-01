
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
        replicasCount = 1
        shardsCount   = 3
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
    })
  ]

  depends_on = [
    helm_release.clickhouse_operator
  ]

  timeout = 900
  wait    = true
}
