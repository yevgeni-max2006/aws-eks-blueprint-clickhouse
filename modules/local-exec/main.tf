
resource "null_resource" "wait_for_clickhouse" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]

    command = <<EOT
set -e

echo "Waiting for ClickHouse pods..."

kubectl wait \
  --namespace clickhouse \
  --for=condition=Ready \
  pod \
  -l clickhouse.altinity.com/chi=clickhouse \
  --timeout=600s

echo "ClickHouse is ready."
EOT
  }
}

resource "null_resource" "clickhouse_database" {
  depends_on = [
    null_resource.wait_for_clickhouse
  ]

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]

    command = <<EOT
set -e

POD=$(kubectl get pods -n clickhouse \
  -l clickhouse.altinity.com/chi=clickhouse \
  -o jsonpath='{.items[0].metadata.name}')

echo "Using ClickHouse pod: $POD"
kubectl exec -n clickhouse $POD -- \
  clickhouse-client \
  --query "CREATE DATABASE IF NOT EXISTS yevgeni"

echo "Database yevgeni ensured."
EOT
  }

  triggers = {
    database = "yevgeni"
  }
}
