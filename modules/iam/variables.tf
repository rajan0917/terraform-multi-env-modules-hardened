variable "name" {
  type = string
}
variable "assume_services" {
  type    = list(string)
  default = ["ec2.amazonaws.com"]
}
variable "attach_policy_arns" {
  type    = list(string)
  default = []
}
variable "inline_policy_json" {
  type    = string
  default = ""
}
variable "example_s3_bucket_arn" {
  type    = string
  default = ""
}
variable "tags" {
  type    = map(string)
  default = {}
}
