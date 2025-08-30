
resource "local_file" "metallb_config" {
  content = templatefile("${path.module}/metallb.config.crd.tmpl",
    {
      metallb_ip_range = var.metallb_ip_range
    }
  )
  filename   = "${path.module}/metallb.config.crd.yaml"
  depends_on = [helm_release.metallb]
}

resource "helm_release" "metallb" {
  name             = "metallb"
  repository       = "https://metallb.github.io/metallb"
  chart            = "metallb"
  namespace        = "metallb-system"
  version          = "0.14.8"
  create_namespace = true
  timeout          = 300
}

resource "null_resource" "wait_for_metallb" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      kubectl apply -f "${path.module}/metallb.config.crd.yaml"
      printf "\nWaiting for the metallb controller...\n"
      kubectl wait --namespace ${helm_release.metallb.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/component=speaker \
        --timeout=90s
    EOF
  }

  depends_on = [helm_release.metallb, local_file.metallb_config]
}
