
resource "null_resource" "gateway_api_crds" {

  provisioner "local-exec" {
    command = <<EOT
      echo "Installing Gateway API CRDs v1.3.0..."

      kubectl apply -k "github.com/kubernetes-sigs/gateway-api/config/crd?ref=v1.3.0"
      echo "Waiting for Gateway API CRDs..."

      kubectl wait \
        --for=condition=Established \
        crd/gateways.gateway.networking.k8s.io \
        --timeout=120s

      kubectl wait \
        --for=condition=Established \
        crd/httproutes.gateway.networking.k8s.io \
        --timeout=120s

      echo "Gateway API CRDs are ready"
    EOT
  }

  triggers = {
    gateway_api_version = "v1.3.0"
  }
}
