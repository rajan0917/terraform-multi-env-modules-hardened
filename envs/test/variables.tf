variable "region" {
  type    = string
  default = "ap-south-1"
}
variable "env" {
  type = string
}
variable "tags" {
  type    = map(string)
  default = {}
}
