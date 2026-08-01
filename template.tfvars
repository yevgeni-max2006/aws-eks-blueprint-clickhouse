
###  ---  Default Template  ---  ###
aws_region      = "eu-central-1"
cluster_name    = "eks-cluster-clickhouse"
cluster_version = "1.35"
instance_types  = ["t3.large"] #t3.medium
node_group_desired_size = 3
node_group_min_size     = 3
node_group_max_size     = 7
