locals {
  eks_cluster_name = "${var.name_prefix}-eks"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = local.eks_cluster_name
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  cluster_version = var.eks_cluster_version

  cluster_additional_security_group_ids = [module.access_from_bastion_sg.security_group_id]

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    eks-pod-identity-agent = {
      most_recent = true
    }
  }

  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions

  eks_managed_node_groups = {
    "${local.eks_cluster_name}-managed" = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }

  cluster_enabled_log_types = [
    "audit",
    "api",
    "authenticator",
    "scheduler",
  ]
  #######
  create_kms_key = var.eks_create_kms_key
  cluster_encryption_config = var.eks_create_kms_key ? {
    "resources" : [
      "secrets"
    ]
  } : {}
  ######
}


module "load_balancer_controller" {
  source  = "DNXLabs/eks-lb-controller/aws"
  version = "0.9.0"

  enabled = true

  cluster_identity_oidc_issuer     = module.eks.cluster_oidc_issuer_url
  cluster_identity_oidc_issuer_arn = module.eks.oidc_provider_arn
  cluster_name                     = module.eks.cluster_name
}
