variable "name" {
  type = string
}
variable "scope" {
  type    = string
  default = "REGIONAL"
}
variable "block_ips" {
  type    = list(string)
  default = []
}
variable "tags" {
  type    = map(string)
  default = {}
}
