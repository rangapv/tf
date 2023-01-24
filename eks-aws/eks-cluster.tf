module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.5.1"

  cluster_name    = local.cluster_name
  cluster_version = "1.24"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  cluster_addons = {
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }

  }


  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

  }


  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
      capacity_type  = "SPOT"    
      disk_size = 25
      use_custom_launch_template = false
      remote_access = {
      ec2_ssh_key               = module.key_pair.key_pair_name 
    }



   }

    two = {
      name = "node-group-2"

      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
      capacity_type  = "SPOT"
      disk_size = 25
      use_custom_launch_template = false
      remote_access = {
      ec2_ssh_key               = module.key_pair.key_pair_name 
   
	}
    }
  }

}
