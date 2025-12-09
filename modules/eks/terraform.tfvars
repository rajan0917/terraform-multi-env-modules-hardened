#cluster_name = "dev-eks"
#subnet_ids = ["subnet-aaa","subnet-bbb","subnet-ccc"]
#create_node_group = true
#log_retention_days = 90
#tags = { Environment = "dev" }
cluster_name = "dev-eks"
cluster_role_name = "dev-eks-role"
node_role_arn = "arn:aws:iam::123456:role/eks-node-role"
subnet_ids = ["subnet-aaa","subnet-bbb","subnet-ccc"]
create_node_group = true
enabled_log_types = ["api","audit"]
endpoint_public_access = true
node_desired_count = 2
node_min_count = 1
node_max_count = 3
instance_types = ["t3.medium"]
region = "us-east-1"
