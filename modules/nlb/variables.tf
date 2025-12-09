variable "name" {
  type = string
}
variable "subnets" {
  type    = list(string)
  default = []
}
variable "vpc_id" {
  type    = string
  default = ""
}
variable "target_port" {
  type    = number
  default = 80
}
variable "target_protocol" {
  type    = string
  default = "TCP"
}
variable "target_type" {
  type    = string
  default = "instance"
}
variable "tags" {
  type    = map(string)
  default = {}
}
