provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    }
  }
}

module "kubernetes_addons" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.25.0"

  eks_cluster_id = data.aws_eks_cluster.cluster.id

  # EKS Add-ons
  enable_metrics_server = true
  enable_amazon_eks_aws_ebs_csi_driver = true
  enable_aws_load_balancer_controller = true
  enable_cert_manager   = true
  enable_kube_prometheus_stack = true
  # enable_cluster_autoscaler = true
}

resource "helm_release" "emqx_operator" {
  depends_on = [module.kubernetes_addons]

  name       = "emqx-operator"
  namespace = "emqx-operator-system"
  create_namespace = true

  repository = "https://repos.emqx.io/charts"
  chart      = "emqx-operator"
}
