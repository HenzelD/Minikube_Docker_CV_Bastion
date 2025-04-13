module "eks" {
  source  = "terraform-aws-modules/eks/aws"


  iam_role_arn = module.eks_cluster_role.iam_role_arn
  cluster_name    = "Cluster"
  cluster_version = "1.31"

  # Optional
  cluster_endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.public_subnets[0],module.vpc.private_subnets[1], module.vpc.public_subnets[1]]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}