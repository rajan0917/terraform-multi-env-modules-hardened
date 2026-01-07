variable "cluster_name" {
  type = string
}
variable "cluster_role_name" {
  type    = string
  default = "eks-cluster-role"
}
variable "node_role_arn" {
  type    = string
  default = ""
}
variable "subnet_ids" {
  type    = list(string)
  default = []
}
variable "create_node_group" {
  type    = bool
  default = true
}
variable "enabled_log_types" {
  type    = list(string)
  default = ["api", "audit", "authenticator"]
}
variable "node_desired_count" {
  type    = number
  default = 2
}
variable "node_min_count" {
  type    = number
  default = 1
}
variable "node_max_count" {
  type    = number
  default = 3
}
variable "instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}
variable "log_retention_days" {
  type    = number
  default = 30
}
variable "tags" {
  type    = map(string)
  default = {}
}
