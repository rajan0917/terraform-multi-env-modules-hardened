output "cluster_endpoint" { value = aws_eks_cluster.this.endpoint }
output "cluster_ca" { value = aws_eks_cluster.this.certificate_authority.0.data }
output "log_group_name" { value = aws_cloudwatch_log_group.eks_control_plane.name }
output "kms_key_arn" { value = aws_kms_key.eks_logs.arn }