
data "external" "subnet" {
  program = ["/bin/bash", "-c", "docker network inspect -f '{{json .IPAM.Config}}' kind | jq .[0]"]
  depends_on = [
    kind_cluster.default
  ]
}

provider "helm" {
  kubernetes {
    config_path = pathexpand(var.kind_cluster_config_path)
  }
}

module "metallb" {
  source = "./modules/metallb"
  depends_on = [kind_cluster.default]
  kind_cluster_config_path = var.kind_cluster_config_path
}

module "nginx" {
  source = "./modules/nginx"
  depends_on = [module.metallb]
}

resource "null_resource" "helm_dependency_update" {
 depends_on = [module.nginx]
 provisioner "local-exec" {
    command = "HELM_EXPERIMENTAL_OCI=1 helm dependency update ./charts/n8n"
  }

  triggers = {
    always_run = timestamp()
  }
}
resource "helm_release" "n8n" {
  namespace  = "n8n"
  create_namespace = true
  depends_on = [null_resource.helm_dependency_update]
  name       = "n8n"
  chart = "${var.charts_path}/n8n/"
}


