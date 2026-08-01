
resource "null_resource" "wait_for_clickhouse" {
  provisioner "local-exec" {
    command = <<EOT
set -euo pipefail

echo "Waiting for ClickHouse pods..."

kubectl wait \
  --namespace clickhouse \
  --for=condition=Ready \
  pod \
  -l clickhouse.altinity.com/chi=clickhouse \
  --timeout=900s

echo "All ClickHouse pods are ready."
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
set -euo pipefail

NAMESPACE=clickhouse
DATABASE=yevgeni

POD=$(kubectl get pods \
  -n $NAMESPACE \
  -l clickhouse.altinity.com/chi=clickhouse \
  -o jsonpath='{.items[0].metadata.name}')

echo "Using ClickHouse pod: $POD"


kubectl exec \
  -n $NAMESPACE \
  $POD -- \
  clickhouse-client \
  --query "CREATE DATABASE IF NOT EXISTS $DATABASE"


echo "Database $DATABASE ensured."
EOT
  }


  triggers = {
    database = "yevgeni"
  }
}
