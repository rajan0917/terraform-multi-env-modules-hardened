variable "bucket_name" {
  type = string
}
variable "acl" {
  type    = string
  default = "private"
}
variable "force_destroy" {
  type    = bool
  default = false
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "versioning" {
  type    = bool
  default = true
}
variable "lifecycle_enabled" {
  type    = bool
  default = true
}
variable "lifecycle_days" {
  type    = number
  default = 365
}
variable "access_log_bucket" {
  type    = string
  default = ""
}
variable "access_log_prefix" {
  type    = string
  default = "logs/"
}
variable "enforce_tls_and_encryption" {
  type    = bool
  default = true
}
