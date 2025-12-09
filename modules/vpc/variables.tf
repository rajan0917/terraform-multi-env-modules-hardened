variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "name" {
  type    = string
  default = "example-vpc"
}
variable "public_subnets" {
  type    = list(string)
  default = []
}
variable "private_subnets" {
  type    = list(string)
  default = []
}
variable "azs" {
  type    = list(string)
  default = []
}
variable "create_nat" {
  type    = bool
  default = false
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "region" {
  type    = string
  default = "us-east-2"
}
